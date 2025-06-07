<?php
    class indexController extends Controller{
        private $_index;
    
    function __construct()
    {
       parent::__construct(); 
       $this->_index = $this->loadModel("index");
    }


    public function getNumeroProductos()
{
    $numero=$this->_index->numeroProductos();
    $productos=json_encode($numero);


    return $productos;
    

}


public function getNumeroPropietarios()
{
    $fila=$this->_index->numeroPropietarios();
   
        $propietarios=json_encode($fila);
        
    
    return $propietarios;
    

} 

public function getProductos()
{
    $fila=$this->_index->obtenerProductos();
    for($i=0;$i<count($fila);$i++){
        $servicios=json_encode($fila);
        
    } 
    return $servicios;
    

}



       public function index()
    {
      $this->_view->productos=$this->getNumeroProductos();
      $this->_view->propietarios=$this->getNumeroPropietarios();
      $this->_view->servicio=$this->getProductos();


       
       $this->_view->renderizar('index');
    }

    }
    
 


?>