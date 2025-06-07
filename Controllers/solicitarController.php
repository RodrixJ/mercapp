<?php
class solicitarController extends Controller
{
    private $_solicitar;

    function __construct()
    {
        parent::__construct();
        $this->_solicitar = $this->loadModel("solicitar");
    }
 
    public function verSolicitud()
    {

        $fila = $this->_solicitar->obtenerSolicitud();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>

           <td>
           <a href="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" data-fancybox="gallery" data-caption="Recuerdo">
            <img src="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" class="img-fluid rounded-start" style="width:100%" alt="">
            </a></td>

          <td>' . $fila[$i]['descripcion_lugar'] . '</td> 
          <td>' . $fila[$i]['fecha_servicio'] . '</td>
          <td>' . $fila[$i]['estado'] . '</td>
           <td>' . $fila[$i]['observaciones'] . '</td>

         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " class="btn btn-info btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarMunicipio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarMunicipio=' . $fila[$i]['id_mantenimiento'] . ' class="btn btn-danger btn-circle btBorrarMunicipio">
   <i class="fas fa-trash"> </i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function verServicio(){

        /* Mandando los servicios a el formulario de solicitar servicio */
        $fila = $this->_solicitar->obtenerServicios();
        $datos = '<option value="0">Seleccione Servicio a Solicitar</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_servicio'] . '">' . $fila[$i]['tipo_servicio'] . '-' . $fila[$i]['descripcion'] . '</option>';
        }
        return $datos;
    }

    public function getDifunto()
    {

        $datos = $this->_solicitar->obtenerDatosFamiliar(Sessiones::getClave('usuario'));

        $id = $datos[0]["familiar_difunto"];
        $fila = $this->_solicitar->obtenerDefuncion($id);

        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) { 
            $datos = json_encode($fila[$i]);
            $tabla .= '
            <a href="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" data-fancybox="gallery" data-caption="Recuerdo">
            <img src="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" class="img-fluid rounded mx-auto d-block" height="200 px" alt="">
            </a>
            
            ';

        }
        return $tabla;

    }

    public function getUbicacion()
    {

        $datos = $this->_solicitar->obtenerDatosFamiliar(Sessiones::getClave('usuario'));

        $id = $datos[0]["familiar_difunto"];
        $fila = $this->_solicitar->obtenerDefuncion($id);
        $data = $fila[0]["id_ubicacion"];

       
       
        return $data;
    }


    

    public function index()
    {

        Sessiones::acceso('familiar');
        $this->_view->servicios = $this->verServicio();
        $this->_view->foto = $this->getDifunto();
        $this->_view->ubicacion = $this->getUbicacion();


        $this->_view->tabla = $this->verSolicitud();

       
 

        $this->_view->renderizar('solicitar');
    }



    public function solicitudServicio(){
        $estado='Pendiente';

        $this->_solicitar->insertarSolicitud($this->getTexto('servicioSolicitado'),$this->getTexto('ubicacionServicio'),$this->getTexto('diaServicio'),$this->getTexto('otrosComentarios'),$estado);
    
        echo $this->verSolicitud();
        }






}




?>