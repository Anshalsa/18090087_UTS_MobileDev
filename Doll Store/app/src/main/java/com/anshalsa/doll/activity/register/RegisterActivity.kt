package com.anshalsa.doll.activity.register

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.anshalsa.doll.R
import com.anshalsa.doll.activity.register.presenter.RegisterPresenter
import com.anshalsa.doll.activity.register.presenter.RegisterView
import com.anshalsa.doll.model.User
import kotlinx.android.synthetic.main.activity_register.*
import org.jetbrains.anko.doAsync
import org.jetbrains.anko.sdk25.coroutines.onClick
import org.jetbrains.anko.toast

class RegisterActivity : AppCompatActivity(), RegisterView {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_register)
        initActionButton()
    }

    private fun initActionButton() {
        btRegister.onClick {
            val username = etRegisterUsername.text.toString()
            val email = etRegisterEmail.text.toString()
            val password = etRegisterPassword.text.toString()
            val hp = etRegisterHp.text.toString()
            if (username.isBlank() || email.isBlank() || password.isBlank() || hp.isBlank()) {
                onErrorRegister("Form wajib diisi")
            } else {
                val user = User()
                user.username = username
                user.email = email
                user.password = password
                user.hp = hp
                RegisterPresenter(this@RegisterActivity).register(user)
            }
        }
        goLogin.onClick {
            finish()
        }
    }

    override fun onSuccessRegister() {
        toast("Berhasil registrasi").show()
        finish()
    }

    override fun onErrorRegister(msg: String?) {
        toast(msg ?: "").show()
    }
}