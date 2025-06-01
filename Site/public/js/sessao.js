// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    // var b_usuario = document.getElementById("b_usuario");

    // ) {
    //     // b_usuario.innerHTML = nome;
    //     alert(`bem vindo ${nome}`)
    // } else

    if (email == null && nome == null) {
        alert('Faça login para acessar!')
        // window.location = "../login.html";
    }
}

function validarLogin() {
    var nome = sessionStorage.NOME_USUARIO;
    if (nome != null) {
        btnsNav.innerHTML = `<a onclick="limparSessao()" class="btnNav">Logout</a>`
    } else {
        btnsNav.innerHTML = `    <a href="./login.html" class="btnNav">LOGIN</a>
                    <a href="./cadastro.html" class="btnNav" id="btnCadastro">CADASTRO</a>`
    }
}

function acessarQuiz() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    if (email == null && nome == null) {
        alert('Faça login para acessar!')
    } else {
        window.location = "../quiz/questoes.html";
    }

}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../index.html";
}

