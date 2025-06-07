<?php

class errorController extends Controller{

    function __construct(){
        parent::__construct();
    }

    public function index(){

       
        
    }

    public function error($num){
        if($num=='505')
            $mensaje='<main>
    <div class="container">

      <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
        <h1>Error</h1>
        <h2>No cuentas con suficientes privilegios para visitar esta pagina.</h2>
        <a class="btn" href="'.BASE_URL.'index">Regresar Al Inicio</a>
        <img src="'.PLANTILLA.'assets/img/logoColor.png" class="img-fluid py-5" alt="Page Not Found">
      </section>

    </div>
  </main>';
        else if($num=='504')
        $mensaje=' <main>
    <div class="container">

      <section class="section error-404 min-vh-100 d-flex flex-column align-items-center justify-content-center">
        <h1>Error</h1>
        <h2>No ha ingresado al sistema</h2>
        <a class="btn" href="'.BASE_URL.'login'.'">Iniciar Sesión</a>
        <img src="'.PLANTILLA.'assets/img/logoColor.png" class="img-fluid py-5" alt="Page Not Found">
      </section>

    </div>
  </main>';

       

        $this->_view->error=$mensaje;
        $this->_view->renderizar('index');
         
    }

}

