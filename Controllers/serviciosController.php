<?php
class serviciosController extends Controller
{
    private $_servicios;

    function __construct()
    {
        parent::__construct();
        $this->_servicios = $this->loadModel("servicios");
    }
 
    public function verServicios()
    {

        $fila = $this->_servicios->obtenerServicios();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_servicio'] . '</td>
          <td>' . $fila[$i]['tipo_servicio'] . '</td>
          <td>' . $fila[$i]['descripcion'] . '</td>
          <td>' . $fila[$i]['precio'] . '</td>
         
          
          <td>
          <button data-Servicio=\'' . $datos . '\' " class="btn btn-warning style="color:#fff" btn-circle btnEditarServicio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarServicio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarServicio=' . $fila[$i]['id_servicio'] . ' class="btn btn-danger btn-circle btBorrarDepartamento">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {
        $this->_view->tabla = $this->verServicios();

        $this->_view->renderizar('servicios');
    }






    /* Funcion que recibe los datos del formulario para agregar departamentos */
    public function agregarServicio(){

        function upload_image()
        {
         if(isset($_FILES["imagenServicio"]))
         {
          $extension = explode('.', $_FILES['imagenServicio']['name']);
          $new_name = rand() . '.' . $extension[1];
          $destination = './Views/plantilla/assets/img/' . $new_name;
          move_uploaded_file($_FILES['imagenServicio']['tmp_name'], $destination);
          return $new_name;
         }
        }
        $image = '';
        if($_FILES["imagenServicio"]["name"] != '')
          {
           $image = upload_image();
        
           $this->_servicios->insertarServicio($this->getTexto('tipoServicio'),$this->getTexto('descripcionServicio'),$this->getTexto('precioServicio'),$image);
           echo $this->verServicios();
           }
           else{
            $this->_servicios->insertarServicioSinImagen($this->getTexto('tipoServicio'),$this->getTexto('descripcionServicio'),$this->getTexto('precioServicio'));
            echo $this->verServicios();
           }
        
          
          
   
        
    }

     



}




?>