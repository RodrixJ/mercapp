<?php
class municipioController extends Controller
{
    private $_municipio;

    function __construct()
    {
        parent::__construct();
        $this->_municipio = $this->loadModel("municipio");
    }
 
    public function verMunicipio()
    {

        $fila = $this->_municipio->obtenerMunicipio();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_municipio'] . '</td>
          <td>' . $fila[$i]['nombre_municipio'] . '</td>
          <td>' . $fila[$i]['nombre_departamento'] . '</td>
         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " class="btn btn-warning" btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarMunicipio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarMunicipio=' . $fila[$i]['id_municipio'] . ' class="btn btn-danger btn-circle btBorrarMunicipio">
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
        $this->_view->tabla = $this->verMunicipio();

         /* Mandando los departamentos a el formulario de agregar */
         $fila = $this->_municipio->obtenerDepartamento();
         $datos = '<option value="0">Seleccione Departamento</option>';
 
         for ($i = 0; $i < count($fila); $i++){
             $datos .= '<option value="' . $fila[$i]['id_departamento'] . '">' . $fila[$i]['nombre_departamento'] . '</option>';
         }
         $this->_view->departamentos = $datos;
 

        $this->_view->renderizar('municipio');
    }






    /* Funcion que recibe los datos del formulario para agregar Municipios */
    public function agregarMunicipio(){
    $this->_municipio->insertarMunicipio($this->getTexto('departamento'), $this->getTexto('nombreMunicipio'));
        echo $this->verMunicipio();
    }

     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function actualizarMunicipio(){
        $this->_municipio->actualizarMunicipio($this->getTexto('idMunicipio'),$this->getTexto('departamentoUP'),$this->getTexto('nombreMunicipioUP')); 
        echo $this->verMunicipio();    
    }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarMunicipio(){
        $this->_municipio->borrarMunicipio($this->getTexto('idMunicipio'));
        echo $this->verMunicipio();
    }



}




?>