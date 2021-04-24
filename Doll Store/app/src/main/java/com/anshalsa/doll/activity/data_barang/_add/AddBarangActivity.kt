package com.anshalsa.doll.activity.data_barang._add

import android.os.Bundle
import com.google.android.material.snackbar.Snackbar
import com.anshalsa.doll.R
import com.anshalsa.doll.base.BaseActivity
import com.anshalsa.doll.model.Barang
import kotlinx.android.synthetic.main.activity_add_barang.*
import org.jetbrains.anko.toast
import java.io.Serializable

class AddBarangActivity : BaseActivity(), AddBarangView {
    override fun onCreate(savedInstanceState: Bundle?) {
        cekSesi(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_add_barang)
        val intent = intent.getSerializableExtra(TAGS.BARANG)
        if (intent != null) {
            setActionEditButton(intent)
        } else {
            setActionTambahButton()
        }
    }

    private fun setActionEditButton(serializable: Serializable) {
        btAddBarang.text = "Simpan"
        val barang = serializable as Barang
        etAddBarangBarcode.setText(barang.barcode)
        etAddBarangNamaBarang.setText(barang.namaBarang)
        etAddBarangKategori.setText(barang.kategori)
        etAddBarangHargaBeli.setText(barang.hargaBeli.toString())
        etAddBarangHargaJual.setText(barang.hargaJual.toString())

        btAddBarang.setOnClickListener {
            val barcode = etAddBarangBarcode.text.toString()
            val nama_barang = etAddBarangNamaBarang.text.toString()
            val kategori = etAddBarangKategori.text.toString()
            val harga_beli_s = etAddBarangHargaBeli.text.toString()
            val harga_jual_s = etAddBarangHargaJual.text.toString()
            if (harga_beli_s.isNotBlank() && harga_jual_s.isNotBlank()) {
                val harga_beli = harga_beli_s.toDouble()
                val harga_jual = harga_jual_s.toDouble()
                barang.idUser = user?.idUser.toString()
                barang.barcode = barcode
                barang.namaBarang = nama_barang.toUpperCase()
                barang.kategori = kategori.toLowerCase().capitalize()
                barang.hargaBeli = harga_beli
                barang.hargaJual = harga_jual
                AddBarangPresenter(this@AddBarangActivity).updateBarang(barang)
            } else {
                Snackbar.make(it, "Harga tidak boleh kosong", Snackbar.LENGTH_SHORT)
            }
        }
    }

    private fun setActionTambahButton() {
        btAddBarang.setOnClickListener {
            btAddBarang.text = "Tambah"
            val barcode = etAddBarangBarcode.text.toString()
            val nama_barang = etAddBarangNamaBarang.text.toString()
            val kategori = etAddBarangKategori.text.toString()
            val harga_beli_s = etAddBarangHargaBeli.text.toString()
            val harga_jual_s = etAddBarangHargaJual.text.toString()
            if (harga_beli_s.isNotBlank() && harga_jual_s.isNotBlank()) {
                val harga_beli = harga_beli_s.toDouble()
                val harga_jual = harga_jual_s.toDouble()

                val barang = Barang()
                barang.idUser = user?.idUser.toString()
                barang.barcode = barcode
                barang.namaBarang = nama_barang.toUpperCase()
                barang.kategori = kategori.toLowerCase().capitalize()
                barang.hargaBeli = harga_beli
                barang.hargaJual = harga_jual

                AddBarangPresenter(this@AddBarangActivity).addBarang(barang)
            } else {
                Snackbar.make(it, "Harga tidak boleh kosong", Snackbar.LENGTH_SHORT)
            }
        }
    }

    /**
     * Result baik edit ataupun hapus sama saja
     */

    override fun onSuccessAddBarang(msg: String?) {
        toast(msg ?: "").show()
        finish()
    }

    override fun onErrorAddBarang(msg: String?) {
        toast(msg ?: "").show()
    }
}
