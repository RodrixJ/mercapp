<?php
class usuarioController extends Controller
{
    private $_usario;

    function __construct()
    {
        parent::__construct();
        $this->_usario = $this->loadModel("usuario");
    }

    public function verificar(){
        $this->_usario->verificarUsuario($this->getTexto('bus'));
        
    }
 
    public function verUsuario()
    {

        $fila = $this->_usario->obtenerUsuario();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= '
          <tr>
          <td>' . $fila[$i]['id_usuario'] . '</td>
          <td>' . $fila[$i]['nombre_usuario'] . '</td>
          <td>' . $fila[$i]['clave'] . '</td>
          <td>' . $fila[$i]['rol'] . '</td>
          
          <td>
          <button data-usuario=\'' . $datos . '\' " class="btn btn-warning style="color:#fff" btn-circle btnEditarUsuario">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarUsuario=' . $fila[$i]['id_usuario'] . ' class="btn btn-danger btn-circle btBorrarUsuario">
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

        $this->_view->tabla = $this->verUsuario();

        $this->_view->renderizar('usuario');
    }







    /* Funcion que recibe los datos del formulario para agregar cementerio */
    public function agregarUsuario(){
    $this->_usario->insertarUsuario($this->getTexto('nombre'),$this->getTexto('clave'),
   $this->getTexto('rol'));

        echo $this->verUsuario();
    }




    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarUsuario(){
        $this->_usario->borrarU($this->getTexto('idU'));
        echo $this->verUsuario();
    }



}




?>