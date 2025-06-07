<?php
class solicitudController extends Controller
{
    private $_solicitud;

    function __construct()
    {
        parent::__construct();
        $this->_solicitud = $this->loadModel("solicitud");
    }
 
    public function verSolicitud()
    {

        $fila = $this->_solicitud->obtenerSolicitud(); 
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>

           <td>
           <a href="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" data-fancybox="gallery" data-caption="Recuerdo">
            <img src="' . PLANTILLA . 'assets/img/' .$fila[$i]['imagen_descanso']. '" class="img-fluid rounded-start" style="width:100%" alt="">
            </a></td>

          <td>' . $fila[$i]['tipo_servicio'] . ' - ' . $fila[$i]['descripcion'] . '</td> 
          <td>' . $fila[$i]['fecha_servicio'] . '</td>
          <td>' . $fila[$i]['estado'] . '</td>
           <td>' . $fila[$i]['observaciones'] . '</td>

         
          
          <td>
          <button data-municipio=\'' . $datos . '\' " class="btn btn-success btn-circle btnEditarMunicipio" data-bs-toggle="modal"
          data-bs-target="#modalActualizarSolicitud">
           <i class="fa-solid fa-check"></i>
            </button>
            <button data-borrarSolicitud=' . $fila[$i]['id_mantenimiento'] . ' class="btn btn-danger btn-circle btCancelarSolicitud">
            <i class="fa-solid fa-xmark"></i>
            </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

   

    

    


    

    public function index()
    {

        Sessiones::acceso('operario');
       

        $this->_view->tabla = $this->verSolicitud();

       
 

        $this->_view->renderizar('solicitud');
    }



    public function cancelarSolicitud(){
        $estado='Cancelado';

        $this->_solicitud->actualizarEstadoSolicitud($this->getTexto('idSolicitud'),$estado);
    
        echo $this->verSolicitud();
        }






}




?>