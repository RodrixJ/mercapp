<?php
class causasController extends Controller
{
    private $_causas;

    function __construct()
    {
        parent::__construct();
        $this->_causas = $this->loadModel("causas");
    }
 
    public function verCausas()
    {

        $fila = $this->_causas->obtenerCausas();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= '
          <tr>
          <td>' . $fila[$i]['id_causa'] . '</td>
          <td>' . $fila[$i]['codigo'] . '</td>
          <td>' . $fila[$i]['descripcion'] . '</td>
          <td>' . $fila[$i]['nombre_categoria'] . '</td>
          <td>
           <button data-causa=\'' . $datos . '\' " class="btn btn-warning style="color:#fff" btn- btnEditarCausa" data-bs-toggle="modal"
          data-bs-target="#modalEditarCausa">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarCausa=' . $fila[$i]['id_causa'] . ' class="btn btn-danger btn-circle  btBorrarCausa">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {


        $this->_view->tabla = $this->verCausas();

         /* Mandando los departamentos a el formulario de agregar */
         $fila = $this->_causas->obtenerCategoria();
         $datos = '<option value="0">Seleccione Categoria</option>';
 
         for ($i = 0; $i < count($fila); $i++){
             $datos .= '<option value="' . $fila[$i]['id'] . '">' . $fila[$i]['nombre_categoria'] . '</option>';
         }
         $this->_view->categorias = $datos;
 

        Sessiones::acceso('administrador');

        $this->_view->renderizar('causas');
    }



    /* Funcion que recibe los datos del formulario para agregar cementerio */
    public function agregarCausa(){
    $this->_causas->insertarCausa($this->getTexto('codigoCIE'),$this->getTexto('nombreCategoria'),
   $this->getTexto('descripcion'));
   echo $this->verCausas();
    }


     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function actualizarCausa(){
        $this->_causas->actualizarCausa($this->getTexto('idCausa'),$this->getTexto('codigoCIEUP'),
       $this->getTexto('nombreCategoriaUP'),$this->getTexto('descripcionUP')); 
       echo $this->verCausas();
        }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarCausa(){
        $this->_causas->borrarCausa($this->getTexto('idCausa'));
        echo $this->verCausas();
    }



}




?>