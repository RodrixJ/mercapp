<?php
class cementerioController extends Controller
{
    private $_cementerio;

    function __construct()
    {
        parent::__construct();
        $this->_cementerio = $this->loadModel("cementerio");
    }
 
    public function verCementerio()
    {

        $fila = $this->_cementerio->obtenerCementerio();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= '
          <tr>
          <td>' . $fila[$i]['id_cementerio'] . '</td>
          <td>' . $fila[$i]['nombre'] . '</td>
          <td>' . $fila[$i]['nombre_municipio'] . '</td>
          <td>' . $fila[$i]['latitud'] . '</td>
          <td>' . $fila[$i]['longitud'] . '</td>
          <td>' . $fila[$i]['capacidad'] . '</td> 
          <td>' . $fila[$i]['tipo'] . '</td>
          <td>' . $fila[$i]['hora_apertura'] . '</td>
          <td>' . $fila[$i]['hora_cierre'] . '</td>
          <td>
          <button data-cementerio=\'' . $datos . '\' " class="btn btn-warning style="color:#fff" btn-circle btnEditarCementerio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarCementerio=' . $fila[$i]['id_cementerio'] . ' class="btn btn-danger btn-circle btBorrarCementerio">
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

        $this->_view->tabla = $this->verCementerio();

        Sessiones::acceso('administrador');
        $this->_view->renderizar('cementerio');
    }

    public function agregar()
    {
        /* Mandando los departamentos a el formulario de agregar municipio */
        $fila = $this->_cementerio->obtenerDepartamento();
        $datos = '<option value="0">Seleccione Departamento</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_departamento'] . '">' . $fila[$i]['nombre_departamento'] . '</option>';
        }
        $this->_view->departamentos = $datos;

        $this->_view->renderizar('agregar');
    }



    public function cargarMunicipio(){
        $fila = $this->_cementerio->obtenerMunicipio($this->getTexto('idDepartamento'));
        $datos = '<option value="0">Seleccione Municipio</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_municipio'] . '">' . $fila[$i]['nombre_municipio'] . '</option>';
        }
        echo $datos;
    }


    /* Funcion que recibe los datos del formulario para agregar cementerio */
    public function agregarCementerio(){
    $this->_cementerio->insertarCementerio($this->getTexto('nombre'),$this->getTexto('municipio'),
   $this->getTexto('latitud'),$this->getTexto('longitud'),
   $this->getTexto('capacidad'),$this->getTexto('tipo'),
   $this->getTexto('horaApertura'),$this->getTexto('horaCierre'));

    }

    public function actualizar()
    {
         /* Mandando los departamentos a el formulario de Actualizar */
        $fila = $this->_cementerio->obtenerDepartamento();
        $datos = '<option value="0">Seleccione Departamento</option>';
 
        for ($i = 0; $i < count($fila); $i++){
             $datos .= '<option value="' . $fila[$i]['id_departamento'] . '">' . $fila[$i]['nombre_departamento'] . '</option>';
        }
        $this->_view->departamentos = $datos;

        

        $this->_view->renderizar('actualizar');
    }

     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function actualizarCementerio(){
        $this->_cementerio->actualizarCementerio($this->getTexto('nombreUp'),$this->getTexto('municipioUp'),
       $this->getTexto('latitudUp'),$this->getTexto('longitudUp'),
       $this->getTexto('capacidadUp'),$this->getTexto('tipoUp'),
       $this->getTexto('horaAperturaUp'),$this->getTexto('horaCierreUp'),$this->getTexto('idCementerioUp')); 
    
        }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarCementerio(){
        $this->_cementerio->borrarCementerio($this->getTexto('idCementerio'));
        echo $this->verCementerio();
    }



}




?>