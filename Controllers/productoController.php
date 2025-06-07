<?php
class productoController extends Controller
{
    private $_producto;

    function __construct()
    {
        parent::__construct();
        $this->_producto = $this->loadModel("producto");
    }
 
    public function verProducto()
    {

        $fila = $this->_producto->obtenerProducto();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_Producto'] . '</td>
          <td>' . $fila[$i]['nombre_producto'] . '</td>
          <td>' . $fila[$i]['precio'] . '</td>
          <td>' . $fila[$i]['marca'] . '</td>
          <td>' . $fila[$i]['descripcion'] . '</td>
          <td> <a href="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen']. '" data-fancybox="gallery" data-caption="producto">
            <img src="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen']. '" class="img-fluid rounded-start" style="height: 50px;" alt="">
            </a></td>
           
         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " style="color:white;" class="btn btn-warning btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarMunicipio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarMunicipio=' . $fila[$i]['id_Producto'] . ' class="btn btn-danger btn-circle btBorrarMunicipio">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {

        
        $this->_view->tabla = $this->verProducto();

         /* Mandando los departamentos a el formulario de agregar */
         $fila = $this->_producto->obtenerTramo();
         $datos = '<option value="0">Seleccione Tramo</option>';
 
         for ($i = 0; $i < count($fila); $i++){
             $datos .= '<option value="' . $fila[$i]['id_Tramo'] . '">' . $fila[$i]['nombreTramo'] . '</option>';
         }
         $this->_view->tramo = $datos;
 

        $this->_view->renderizar('producto');
    }







     /* Funcion que recibe los datos del formulario para agregar departamentos */
    public function agregarProducto(){

        function upload_image()
        {
         if(isset($_FILES["imagen"]))
         {
          $extension = explode('.', $_FILES['imagen']['name']);
          $new_name = rand() . '.' . $extension[1];
          $destination = './Views/plantilla/assets/img/' . $new_name;
          move_uploaded_file($_FILES['imagen']['tmp_name'], $destination);
          return $new_name;
         }
        }
        $image = '';
        if($_FILES["imagen"]["name"] != '')
          {
           $image = upload_image();
        
           $this->_producto->insertarProducto(
            $this->getTexto('nombre'),
            $this->getTexto('marca'),
            $this->getTexto('precio'),
            $this->getTexto('descripcion'),
            $image,
            $this->getTexto('tramo'));
            echo $this->verProducto();
           }
           else{
           $this->_producto->insertarProductoSinImagen(
            $this->getTexto('nombre'),
            $this->getTexto('marca'),
            $this->getTexto('precio'),
            $this->getTexto('descripcion'),
            $this->getTexto('tramo'));
            echo $this->verProducto();
           }
        
          
          
   
        
    }

    



}




?>