package com.anshalsa.doll.activity.report.presenter

import com.anshalsa.doll.model.Keranjang

interface ReportView {
    fun onSuccessReport(keranjang: List<Keranjang?>?)
    fun onFailedReport(localizedMessage: String?)
    fun onSuccessRestore(msg: String?)
    fun onFailedRestore(msg: String?)
}