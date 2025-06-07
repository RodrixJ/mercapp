<?php
class recuerdoController extends Controller
{
    private $_recuerdo;

    function __construct()
    {
        parent::__construct();
        $this->_recuerdo = $this->loadModel("recuerdo");
    }

    public function verRecuerdo($id)
    {

        $fila = $this->_recuerdo->obtenerDifunto();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['id_defuncion'] . '</td>
          <td>' . $fila[$i]['primer_nombre'] . ' ' . $fila[$i]['segundo_nombre'] . '</td>
         
          
          <td>
          <button data-departamento=\'' . $datos . '\' " class="btn btn-info btn-circle btnEditarDepartamento" data-bs-toggle="modal"
          data-bs-target="#modalActualizarDepartamento">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarDepartamento=' . $fila[$i]['id_defuncion'] . ' class="btn btn-danger btn-circle btBorrarDepartamento">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }


    public function getDifunto()
    {

        $datos = $this->_recuerdo->obtenerDatosFamiliar(Sessiones::getClave('usuario'));

        $id = $datos[0]["familiar_difunto"];
        $fila = $this->_recuerdo->obtenerDefuncion($id);
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= '
        <tr>
        <td>' . $fila[0]['id_defuncion'] . '</td>
        <td>' . $fila[$i]['primer_nombre'] . ' ' . $fila[$i]['segundo_nombre'] . ' '. $fila[$i]['primer_apellido']  . ' ' .$fila[$i]['segundo_apellido'] . '</td>
        <td>
        <button data-recuerdo=\'' . $datos . '\' " data-bs-toggle="modal"
          data-bs-target="#modalAgregarRecuerdo" class="btn btn-info btn-circle btnAgregarRecuerdo">
            <i class="fa-solid fa-monument"></i>
            </button>

        </td>
  
        </tr>';

        }
        return $tabla;

    }


    public function index()
    {
        Sessiones::acceso('familiar');



        $this->_view->tabla = $this->getDifunto();

        $this->_view->renderizar('recuerdo');
    }






    /* Funcion que recibe los datos del formulario para agregar departamentos */
    public function insertarRecuerdo()
    {
        function upload_image()
        {
            if (isset($_FILES["recurso"])) {
                $extension = explode('.', $_FILES['recurso']['name']);
                $new_name = rand() . '.' . $extension[1];
                $destination = './Views/plantilla/assets/img/' . $new_name;
                if (move_uploaded_file($_FILES['recurso']['tmp_name'], $destination)) {
                    return $new_name;
                } else {
                    return false; // Retorna false si hay un error en la subida
                }
            }
            return false;
        }
        $image = '';
        if (isset($_FILES["recurso"]) && $_FILES["recurso"]["error"] == 0) {

            $image = upload_image();

            $this->_recuerdo->ingresarRecuerdo($this->getTexto('idDefu'),$this->getTexto('descripcionRecuerdo'), $image);


            echo true;
        } else {



            echo false;
        }
    }
 

}




?>