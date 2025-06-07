<?php
class propietarioController extends Controller
{
    private $_prop;

    function __construct()
    {
        parent::__construct();
        $this->_prop = $this->loadModel("propietario");
    }
 
    public function verPropietario()
    {

        $fila = $this->_prop->obtenerPropietario();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_Propietario'] . '</td>
          <td>' . $fila[$i]['nombre'] . '</td>
         
         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " style="color:white;" class="btn btn-warning btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarMunicipio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarMunicipio=' . $fila[$i]['id_Propietario'] . ' class="btn btn-danger btn-circle btBorrarMunicipio">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {

       
        $this->_view->tabla = $this->verPropietario();

         
 

        $this->_view->renderizar('propietario');
    }






 

    public function agregarPropietario(){
        $this->_prop->insertarPropietario($this->getTexto('nombre'));
        echo $this->verPropietario();   
    }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarMunicipio(){
        $this->_municipio->borrarMunicipio($this->getTexto('idMunicipio'));
        echo $this->verMunicipio();
    }



}




?>