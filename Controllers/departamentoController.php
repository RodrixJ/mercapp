<?php
class departamentoController extends Controller
{
    private $_departamento;

    function __construct()
    {
        parent::__construct();
        $this->_departamento = $this->loadModel("departamento");
    }
 
    public function verdepartamento()
    {

        $fila = $this->_departamento->obtenerDepartamento();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_departamento'] . '</td>
          <td>' . $fila[$i]['nombre_departamento'] . '</td>
         
          
          <td>
          <button data-departamento=\'' . $datos . '\' " class="btn btn-warning style="color:#fff"" btn-circle" btnEditarDepartamento" data-bs-toggle="modal"
          data-bs-target="#modalActualizarDepartamento">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarDepartamento=' . $fila[$i]['id_departamento'] . ' class="btn btn-danger btn-circle btBorrarDepartamento">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {

        Sessiones::acceso('administrador');
        $this->_view->tabla = $this->verDepartamento();

        $this->_view->renderizar('departamento');
    }






    /* Funcion que recibe los datos del formulario para agregar departamentos */
    public function agregarDepartamento(){
    $this->_departamento->insertarDepartamento($this->getTexto('nombreDepartamento'));
        echo $this->verDepartamento();
    }

     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function actualizarDepartamento(){
        $this->_departamento->actualizarDepartamento($this->getTexto('idDepartamentoUp'),$this->getTexto('nombreDepartamentoUp')); 
        echo $this->verDepartamento();    
    }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarDepartamento(){
        $this->_departamento->borrarDepartamento($this->getTexto('idDepartamento'));
        echo $this->verDepartamento();
    }



}




?>