// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    // var b_usuario = document.getElementById("b_usuario");

    // ) {
    //     // b_usuario.innerHTML = nome;
    //     alert(`bem vindo ${nome}`)
    // } else

    if(email == null && nome == null)  {
        alert('Faça login, para postar videos!')
        // window.location = "../login.html";
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

