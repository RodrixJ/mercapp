<?php
class proveedorController extends Controller
{
    private $_proveedor;

    function __construct()
    {
        parent::__construct();
        $this->_proveedor = $this->loadModel("proveedor");
    }
 
    public function verProveedor()
    {

        $fila = $this->_proveedor->obtenerProveedor();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_proveedor'] . '</td>
          <td>' . $fila[$i]['nombre_completo'] . '</td>
          <td>' . $fila[$i]['telefono'] . '</td>
          <td>' . $fila[$i]['direccion'] . '</td>
          <td>' . $fila[$i]['nombre'] . '</td>

         
          
          <td>
          <button data-Proveedor=\'' . $datos . '\' " class="btn btn-info btn-circle btnEditarProveedor" data-bs-toggle="modal"
          data-bs-target="#modalActualizarProveedor">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarProveedor=' . $fila[$i]['id_proveedor'] . ' class="btn btn-danger btn-circle btBorrarProveedor">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }


    public function cargarOperario(){
      $fila = $this->_proveedor->obtenerOperario();
      $datos = '<option value="0">Seleccione Operario</option>';

      for ($i = 0; $i < count($fila); $i++){
          $datos .= '<option value="' . $fila[$i]['id_operario'] . '">' . $fila[$i]['nombre_completo'] . '  - ' . $fila[$i]['especialidad'] . '</option>';

      }
      return $datos;
  }

  public function cargarServicios(){
    $fila = $this->_proveedor->obtenerServicio();
    $datos = '<option value="0">Seleccione Servicio</option>';

    for ($i = 0; $i < count($fila); $i++){
        $datos .= '<option value="' . $fila[$i]['id_servicio'] . '">' . $fila[$i]['tipo_servicio'] . '  - ' . $fila[$i]['descripcion'] . '</option>';

    }
    return $datos;
}

    public function servicios(){

    }

    public function index()
    {
        $this->_view->tabla = $this->verProveedor();
        /* enviando datos a la vista para que se carguen en le formulario */
        $this->_view->operarios = $this->cargarOperario();
        $this->_view->servicios = $this->cargarServicios();

        $this->_view->renderizar('proveedor');
    }






    /* Funcion que recibe los datos del formulario para agregar departamentos */
   

     



}




?>