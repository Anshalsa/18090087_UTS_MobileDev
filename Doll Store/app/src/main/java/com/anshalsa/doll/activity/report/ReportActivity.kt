package com.anshalsa.doll.activity.report

import android.os.Bundle
import android.util.Log
import android.util.Log.d
import com.anshalsa.doll.R
import com.anshalsa.doll.activity.report.adapter.ReportAdapter
import com.anshalsa.doll.activity.report.detail.DetailReportFragment
import com.anshalsa.doll.activity.report.presenter.ReportPresenter
import com.anshalsa.doll.activity.report.presenter.ReportView
import com.anshalsa.doll.base.BaseActivity
import com.anshalsa.doll.model.Keranjang
import com.anshalsa.doll.model.KeranjangStatus
import com.anshalsa.doll.model.Penjualan
import kotlinx.android.synthetic.main.activity_report.*
import org.jetbrains.anko.toast

class ReportActivity : BaseActivity(), ReportView {
    private lateinit var presenter: ReportPresenter
    override fun onCreate(savedInstanceState: Bundle?) {
        cekSesi(this)
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_report)
        presenter = ReportPresenter(this)
        presenter.getReportAll(user?.idUser)
    }

    override fun onSuccessReport(keranjang: List<Keranjang?>?) {
        rvReport.adapter = ReportAdapter(keranjang, object : ReportAdapter.OnClick {
            override fun click(keranjang: Keranjang?, position: Int) {
                val bundle = Bundle()
                bundle.putSerializable("penjualan", keranjang)
                val detailReportFragment = DetailReportFragment()
                detailReportFragment.arguments = bundle
                detailReportFragment.show(supportFragmentManager, "Report")
            }

            override fun restore(keranjang: Keranjang?) {
                presenter.restoreStatus(user?.idUser, Integer.parseInt(keranjang?.idKeranjang),
                        KeranjangStatus.PENDING.status, Integer.parseInt(keranjang?.qty), keranjang?.totalHarga)
            }
        })
    }

    override fun onFailedReport(localizedMessage: String?) {
        d("ReportActivity", localizedMessage.toString())
    }

    override fun onSuccessRestore(msg: String?) {
        toast("Berhasil membatalkan penjualan").show()
        presenter.getReportAll(user?.idUser)
    }

    override fun onFailedRestore(msg: String?) {
        d("ReportActivity", msg.toString())
    }
}
