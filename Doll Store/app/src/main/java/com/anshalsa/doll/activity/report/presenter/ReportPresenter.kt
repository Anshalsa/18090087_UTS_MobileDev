package com.anshalsa.doll.activity.report.presenter

import com.anshalsa.doll.activity.penjualan.data.ResultKeranjang
import com.anshalsa.doll.network.NetworkConfig
import com.anshalsa.doll.response.ResultSimple
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response

class ReportPresenter(val reportView: ReportView) {
    fun getReportAll(id_user: Int?) {
        NetworkConfig.service()
            .getReport(id_user)
            .enqueue(object: Callback<ResultKeranjang>{
                override fun onFailure(call: Call<ResultKeranjang>, t: Throwable) {
                    reportView.onFailedReport(t.localizedMessage)
                }
                override fun onResponse(
                        call: Call<ResultKeranjang>,
                        response: Response<ResultKeranjang>
                ) {
                    val body = response.body()
                    if (body?.status == 200) {
                        reportView.onSuccessReport(body.keranjang)
                    } else {
                        reportView.onFailedReport(body?.message)
                    }
                }
            })
    }

    fun restoreStatus(id_user : Int?, id_keranjang : Int?,status : String?,qty : Int?,total_harga : Double?) {
        NetworkConfig.service()
            .jualBarang(id_user, id_keranjang, status, qty, total_harga)
            .enqueue(object: Callback<ResultSimple>{
                override fun onFailure(call: Call<ResultSimple>, t: Throwable) {
                    reportView.onFailedRestore(t.localizedMessage)
                }
                override fun onResponse(
                        call: Call<ResultSimple>,
                        response: Response<ResultSimple>
                ) {
                    val body = response.body()
                    if (body?.status == 200) {
                        reportView.onSuccessRestore(body?.message)

                    } else {
                        reportView.onFailedRestore(body?.message)
                    }
                }
            })
    }
}