package com.anshalsa.doll.activity.penjualan

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.ArrayAdapter
import androidx.core.widget.addTextChangedListener
import com.anshalsa.doll.R
import com.anshalsa.doll.activity.penjualan.adapter.PenjualanAdapter
import com.anshalsa.doll.activity.penjualan.presenter.PenjualanPresenter
import com.anshalsa.doll.activity.penjualan.presenter.PenjualanView
import com.anshalsa.doll.activity.report.adapter.ReportAdapter
import com.anshalsa.doll.base.BaseActivity
import com.anshalsa.doll.model.Barang
import com.anshalsa.doll.model.Keranjang
import com.anshalsa.doll.model.KeranjangStatus
import com.anshalsa.doll.model.Penjualan
import com.anshalsa.doll.utils.Uang
import kotlinx.android.synthetic.main.activity_penjualan_barang.*
import org.jetbrains.anko.*
import org.jetbrains.anko.sdk25.coroutines.onClick

class PenjualanBarang : BaseActivity(), PenjualanView {
    private lateinit var penjualanPresenter : PenjualanPresenter
    private var listKeranjang : List<Keranjang?>? = null
    private var keranjangNow : Keranjang? = null
    private var keranjangIndex : Int = 0
    private var totalQty : Int = 0
    private var totalHarga : Double = 0.0
    private var barangNow : Barang? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        cekSesi(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_penjualan_barang)
        penjualanPresenter = PenjualanPresenter(this)
        setAction()
        getKeranjang()
    }

    private fun getKeranjang() {
        penjualanPresenter.getKeranjang(KeranjangStatus.PENDING.status, user?.idUser)
    }

    override fun onSuccessGetKeranjang(keranjang: List<Keranjang?>?) {
        listKeranjang = keranjang
        keranjangNow = listKeranjang?.get(keranjangIndex)
        val penjualan = keranjangNow?.penjualan
        rvKeranjangBarang.adapter = PenjualanAdapter(penjualan, object : PenjualanAdapter.OnDelete {
            override fun click(penjualan: Penjualan?) {
                penjualanPresenter.deleteItemKeranjang(penjualan)
            }
        })
        if (penjualan != null) {
            totalQty = 0
            totalHarga = 0.0
            for (i in penjualan.iterator())
            {
                totalQty += i?.qty ?: 0
                totalHarga += i?.qty?.let { i.hargaJual?.times(it) } ?:  0.0
            }
            tvKeranjangTotalQty.text = "$totalQty"
            tvKeranjangTotalHarga.text = "${Uang.indonesia(totalHarga)}"
        }

        tvKeranjangNow.text = keranjang?.size.toString()
        rvKeranjang.adapter = ReportAdapter(listKeranjang, object : ReportAdapter.OnClick {
            override fun restore(keranjang: Keranjang?) {}
            override fun click(keranjang: Keranjang?, position: Int) {
                keranjangIndex = position
                getKeranjang()
                rvKeranjang.visibility = View.GONE
            }
        })
    }

    private fun moveToKeranjang() {
        val qtys = etQty.text.toString()
        if (qtys.isNotBlank()) {
            val qty = qtys.toInt()
            penjualanPresenter.addItemToKeranjang(qty, barangNow, keranjangNow)
        } else {
            toast("Qty wajib diisi").show()
        }
    }

    override fun onFailedGetKeranjang(msg: String?) {
        Log.d("PenjualanBarang", msg ?: "")
    }

    private fun setAction() {
        etSearchBarang.addTextChangedListener {
            val input = etSearchBarang.text.toString()
            if (input == "") {
                barangNow = null
                changeVisibility(View.GONE)
            } else {
                doAsync {
                    penjualanPresenter.searchBarang(input, user?.idUser)
                }
            }
        }

        btAddToKeranjang.onClick {
            if (barangNow != null)
            moveToKeranjang()
        }

        btBayar.setOnClickListener {
            if (totalQty > 0) {
                alert {
                    title ="Aksi"
                    message = "Bayar transaksi ?"
                    yesButton {
                        penjualanPresenter.jualBarang(user?.idUser, Integer.parseInt(keranjangNow?.idKeranjang), KeranjangStatus.TERJUAL.status,
                            totalQty, totalHarga)
                    }
                    noButton {  }
                }.show()
            } else {
                toast("Keranjang kosong").show()
            }
        }

        imKeranjangNow.setOnClickListener {
            rvKeranjang.visibility = if (rvKeranjang.visibility == View.GONE) {
                View.VISIBLE
            } else {
                View.GONE
            }
        }

        imKeranjangAdd.setOnClickListener {
            penjualanPresenter.addKeranjang(user?.idUser)
        }

        imKeranjangDelete.setOnClickListener {
            if (listKeranjang?.size ?: 0 > 1) {
                alert {
                    title ="Aksi"
                    message = "Hapus keranjang ?\nTotal: "+ Uang.indonesia(keranjangNow?.totalHarga ?: 0.0)
                    yesButton {
                        penjualanPresenter.jualBarang(user?.idUser, Integer.parseInt(keranjangNow?.idKeranjang), KeranjangStatus.TERHAPUS.status,
                            totalQty, totalHarga)
                    }
                    noButton {  }
                }.show()
            } else {
                toast("Tidak bisa menghapus keranjang sisa 1").show()
            }
        }
    }

    private fun changeVisibility(v : Int) {
        lvResultSearch.visibility = v
    }

    override fun onSuccessSearchItem(barangs: List<Barang?>?) {
        val onlyName = barangs?.map {
            it?.namaBarang
        }

        if (barangs?.size == 1) {
            barangNow = barangs[0]
        }

        changeVisibility(View.VISIBLE)
        lvResultSearch.adapter =
            onlyName?.let { ArrayAdapter(this, android.R.layout.simple_list_item_1, it) }

        lvResultSearch.setOnItemClickListener { _, _, position, _ ->
            barangNow = barangs?.get(position)
            etSearchBarang.setText(barangNow?.barcode)
            etQty.requestFocus()
        }
    }
    override fun onFailedSearchItem(msg: String?) {
        changeVisibility(View.GONE)
    }
    override fun onSuccessAddItemToKeranjang(msg: String?) {
        getKeranjang()
        etSearchBarang.setText("")
        etQty.setText("1")
        changeVisibility(View.GONE)
    }
    override fun onFailedAddItemToKeranjang(msg: String?) {
        Log.d("PenjualanBarang", msg ?: "")
    }
    override fun onSuccessDeleteItemKeranjang(msg: String?) {
        getKeranjang()
    }
    override fun onFailedDeleteItemKeranjang(msg: String?) {
        Log.d("PenjualanBarang", msg ?: "")
    }
    override fun onSuccessJualBarang(msg: String?) {
        keranjangIndex = 0
        getKeranjang()
    }
    override fun onFailedJualBarang(msg: String?) {
        Log.d("PenjualanBarang", msg ?: "")
    }

    override fun onSuccessAddKeranjang(msg: String?) {
        getKeranjang()
        keranjangIndex = listKeranjang?.size ?: 0
    }
    override fun onFailedAddKeranjang(msg: String?) {
        Log.d("PenjualanBarang", msg ?: "")
    }
}
