<?php
class tramoController extends Controller
{
    private $_tramo;

    function __construct()
    {
        parent::__construct();
        $this->_tramo = $this->loadModel("tramo");
    }
 
    public function verTramo()
    {

        $fila = $this->_tramo->obtenerTramo();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_Tramo'] . '</td>
          <td>' . $fila[$i]['nombreTramo'] . '</td>
          <td>' . $fila[$i]['nombre'] . '</td>
         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " style="color:white;" class="btn btn-warning btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarMunicipio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarMunicipio=' . $fila[$i]['id_Tramo'] . ' class="btn btn-danger btn-circle btBorrarMunicipio">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {

        
        $this->_view->tabla = $this->verTramo();

         /* Mandando los departamentos a el formulario de agregar */
         $fila = $this->_tramo->obtenerPropietario();
         $datos = '<option value="0">Seleccione Propietario</option>';
 
         for ($i = 0; $i < count($fila); $i++){
             $datos .= '<option value="' . $fila[$i]['id_Propietario'] . '">' . $fila[$i]['nombre'] . '</option>';
         }
         $this->_view->propietario = $datos;
 

        $this->_view->renderizar('tramo');
    }






    /* Funcion que recibe los datos del formulario para agregar Municipios */
    public function agregarTramo(){
    $this->_tramo->insertarTramo($this->getTexto('tramo'), $this->getTexto('propietario'));
        echo $this->verTramo();
    }

    



}




?>