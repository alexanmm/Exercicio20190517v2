package com.example.exercicio20190517v2;

import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.design.widget.TextInputLayout;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

public class LoginActivity extends AppCompatActivity {

    TextInputLayout textInputLayoutNome;
    TextInputLayout textInputLayoutEmail;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login);

//1 - Baseado no layout (Link) crie uma novo projeto para cadastro de usuários,
//valide os campos de nome e email quando o usuário clicar no componente
//FloatActionButton, e caso os campos estejam preenchidos mostre uma
//mensagem de “Usuário cadastrado com sucesso”, Caso contrário mostre no
//componente TextInputLayout a mensagem “Campo deve ser preenchido” , use
//os princípios e componentes do material design.
//Obs: Neste exercício use os componentes, TextInputLayout, TextInputEditText,
//CoordinatorLayout, AppBarLAyout, Toolbar, FloatActionButton, Snackbar e
//ImageView

        //Inicializa objetos
        textInputLayoutNome = findViewById(R.id.textInputLayoutNome);
        textInputLayoutEmail = findViewById(R.id.textInputLayoutEmail);

        FloatingActionButton fab = findViewById(R.id.fab);

        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                validaDados();

            }
        });


    }

    public void validaDados() {

        String nome;
        String email;
        String mensagem;

        nome = textInputLayoutNome.getEditText().getText().toString();
        email = textInputLayoutEmail.getEditText().getText().toString();

        textInputLayoutNome.setError("");
        textInputLayoutEmail.setError("");

        if (nome.isEmpty()){
            textInputLayoutNome.setError("Campo deve ser preenchido");
            return;
        }

        if (email.isEmpty()){
            textInputLayoutEmail.setError("Campo deve ser preenchido");
            return;
        }

        mensagem = "Usuário cadastrado com sucesso";

        Snackbar.make(textInputLayoutNome, mensagem, Snackbar.LENGTH_LONG)
                .setAction("Action", null).show();

    }
}
