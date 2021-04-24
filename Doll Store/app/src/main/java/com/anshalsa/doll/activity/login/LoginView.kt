package com.anshalsa.doll.activity.login

import com.anshalsa.doll.model.User

interface LoginView {
    fun onSuccessLogin(user: User?)
    fun onErrorLogin(msg: String?)
}