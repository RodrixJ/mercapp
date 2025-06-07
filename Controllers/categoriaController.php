<?php
class categoriaController extends Controller
{
    private $_categoria;

    function __construct()
    {
        parent::__construct();
        $this->_categoria = $this->loadModel("categoria");
    }
 
    public function verCategoria()
    {

        $fila = $this->_categoria->obtenerCategoria();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id'] . '</td>
          <td>' . $fila[$i]['nombre_categoria'] . '</td>
         
          
          <td>
          <button data-categoria=\'' . $datos . '\' " class="btn btn-warning" style="color:#fff" btn-circle btnEditarCategoria" data-bs-toggle="modal"
          data-bs-target="#modalActualizarCategoria">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarCategoria=' . $fila[$i]['id'] . ' class="btn btn-danger btn-circle btBorrarCategoria">
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
        $this->_view->tabla = $this->verCategoria();

        $this->_view->renderizar('categoria');
    }






    /* Funcion que recibe los datos del formulario para agregar categorias */
    public function agregarCategoria(){
    $this->_categoria->insertarCategoria($this->getTexto('nombreCategoria'));

        echo $this->verCategoria();
    }

     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function actualizarCategoria(){
        $this->_categoria->actualizarCategoria($this->getTexto('idCategoriaUp'),$this->getTexto('nombreCategoriaUp')); 
        echo $this->verCategoria();    
    }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarCategoria(){
        $this->_categoria->borrarCategoria($this->getTexto('idCategoria'));
        echo $this->verCategoria();
    }



}




?>