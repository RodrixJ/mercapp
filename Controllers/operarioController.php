<?php
class operarioController extends Controller
{
    private $_operario;

    function __construct()
    {
        parent::__construct();
        $this->_operario = $this->loadModel("operario");
    }

    public function verOperario()
    {

        $fila = $this->_operario->obtenerOperario();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_operario'] . '</td>
          <td>
           <a href="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagenOperario']. '" data-fancybox="gallery" data-caption="Recuerdo">
            <img src="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagenOperario']. '" class="img-fluid rounded-start" style="width:100%" alt="">
            </a></td>
          <td>' . $fila[$i]['nombre_completo'] . '</td> 
          <td>' . $fila[$i]['telefono'] . '</td>
          <td>' . $fila[$i]['direccion'] . '</td>
          <td>' . $fila[$i]['especialidad'] . '</td>
          <td>' . $fila[$i]['estado'] . '</td>
          <td>' . $fila[$i]['nombre'] . '</td>

         
          
          <td>
          <button data-Operario=\'' . $datos . '\' " class="btn btn-info btn-circle btnEditarOperario" data-bs-toggle="modal"
          data-bs-target="#modalActualizarOperario">
            <i class="fas fa-info-circle"> </i>
            </button>
        <button data-borrarOperario=' . $fila[$i]['id_operario'] . ' class="btn btn-danger btn-circle btBorrarOperario">
        <i class="fas fa-trash"> </i>
        </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function  obtenerCementerio(){
        $fila = $this->_operario->obtenerCementerio();
        $datos = '<option value="0">Seleccione Cementerio</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_cementerio'] . '">' . $fila[$i]['nombre'] . '</option>';
        }
        return $datos;
    }


    public function index()
    {
        $this->_view->tabla = $this->verOperario();
        $this->_view->cementerios = $this->obtenerCementerio();


        $this->_view->renderizar('operario');
    }






    /* Funcion que recibe los datos del formulario para agregar operios y los manda al modelo para hacer el insert */
    public function agregarOperario(){

        function upload_image()
        {
         if(isset($_FILES["fotoOperario"]))
         {
          $extension = explode('.', $_FILES['fotoOperario']['name']);
          $new_name = rand() . '.' . $extension[1];
          $destination = './Views/plantilla/assets/img/' . $new_name;
          move_uploaded_file($_FILES['fotoOperario']['tmp_name'], $destination);
          return $new_name;
         }
        }
        $image = '';
        if($_FILES["fotoOperario"]["name"] != '')
          {
           $image = upload_image();
        
           $this->_operario->insertarOperario($this->getTexto('nombreOperario'),
           $this->getTexto('telefonoOperario'), 
           $this->getTexto('estadoOperario'),
           $this->getTexto('especialidadOperario'),
           $this->getTexto('cementerioOperario'),
           $this->getTexto('direccionOperario'),$image,$this->getTexto('userOperario'),$this->getTexto('claveOperario'));
           echo $this->verOperario();
           }
           else{
            $this->_operario->insertarOperarioSinImagen($this->getTexto('nombreOperario'),
           $this->getTexto('telefonoOperario'), 
           $this->getTexto('estadoOperario'),
           $this->getTexto('especialidadOperario'),

           $this->getTexto('direccionOperario'));
           echo $this->verOperario();
           }
        
          
          
   
        
    }





}




?>