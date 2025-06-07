<?php
class ubicacionController extends Controller
{
    private $_ubicacion;

    function __construct()
    {
        parent::__construct();
        $this->_ubicacion = $this->loadModel("ubicacion");
    }
 
    public function verUbicacion()
    {

        $fila = $this->_ubicacion->obtenerUbicacion();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['primer_nombre'] . ' ' . $fila[$i]['segundo_nombre'] . ' ' . $fila[$i]['primer_apellido'] . ' ' . $fila[$i]['segundo_apellido'] . '</td>
          <td>' . $fila[$i]['cedula'] . '</td>
          <td>' . $fila[$i]['fecha_nacimiento'] . '</td>
          <td>' . $fila[$i]['fecha_ocurrencia'] . '</td>
       
         
          
          <td>
          <button data-ubicacion=\'' . $datos . '\' " class="btn btn-info btn-circle btnAgregarUbicacion" data-bs-toggle="modal"
          data-bs-target="#modalAsignarUbicacion">
<i class="fa-solid fa-location-dot"></i>
            </button>
   

          </td>
  
          </tr>';

        }

        return $tabla;


    }


    public function verAsignados()
    {

        $fila = $this->_ubicacion->obtenerAsignados();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= ' 
          <tr>
          <td>' . $fila[$i]['primer_nombre'] . ' ' . $fila[$i]['segundo_nombre'] . ' ' . $fila[$i]['primer_apellido'] . ' ' . $fila[$i]['segundo_apellido'] . '</td>
          <td>' . $fila[$i]['cedula'] . '</td>
          <td>' . $fila[$i]['fecha_nacimiento'] . '</td>
          <td>' . $fila[$i]['fecha_ocurrencia'] . '</td>
          <td>' . $fila[$i]['latitud'] . '</td>
          <td>' . $fila[$i]['longitud'] . '</td>
       
         
          
          <td>
          <div class="d-inline-flex">
          <button style="color:white;font-weight:bold" data-asignado=\'' . $datos . '\' " class="btn btn-warning btn-circle me-2 btnEditarAsignacion" data-bs-toggle="modal"
          data-bs-target="#modalEditarAsignacion">
<i class="fa-solid fa-rotate-right"></i> Actualizar
            </button>

             </button>
   <button data-borrarUbicacion=' . $fila[$i]['id_ubicacion'] . ' class="btn btn-danger btn-circle btBorrarUbicacion">
   <i class="fas fa-trash"> </i>
   </button>
   </div>
   

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function index()
    {
        $this->_view->tabla = $this->verUbicacion();
        $this->_view->cementerios =$this->cargarCementerios();
 

        $this->_view->renderizar('ubicacion');
    }

    public function asignados()
    {
        $this->_view->tabla = $this->verAsignados();
       
        $this->_view->cementerios =$this->cargarCementerios();

        $this->_view->renderizar('asignados');
    }






    /* Funcion que recibe los datos del formulario para agregar Municipios */
    public function asignarUbicacion()
    {
        function upload_image()
        {
            if (isset($_FILES["fotoUbicacion"])) {
                $extension = explode('.', $_FILES['fotoUbicacion']['name']);
                $new_name = rand() . '.' . $extension[1];
                $destination = './Views/plantilla/assets/img/' . $new_name;
                if (move_uploaded_file($_FILES['fotoUbicacion']['tmp_name'], $destination)) {
                    return $new_name;
                } else {
                    return false; // Retorna false si hay un error en la subida
                }
            }
            return false;
        }
        $image = '';
        if (isset($_FILES["fotoUbicacion"]) && $_FILES["fotoUbicacion"]["error"] == 0) {

            $image = upload_image();

            $this->_ubicacion->insertarUbicacion($this->getTexto('idDifunto'), $this->getTexto('cemterioDescansa'), $this->getTexto('latitudUbicacion'), $this->getTexto('longitudUbicacion'), $this->getTexto('descripcionLugar'),$image);
            echo $this->verUbicacion();

            
        } else {



            $this->_ubicacion->insertarUbicacionSinImagen($this->getTexto('idDifunto'), $this->getTexto('cemterioDescansa'), $this->getTexto('latitudUbicacion'), $this->getTexto('longitudUbicacion'), $this->getTexto('descripcionLugar'));
            echo $this->verUbicacion();
        }
    }

    

    public function cargarCementerios(){
        $fila = $this->_ubicacion->obtenerCementerios();
        $datos = '<option value="0">Seleccione Cementerio</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_cementerio'] . '">' . $fila[$i]['nombre'] . '</option>';
        }
        return $datos;
        
    }

     /* Funcion que recibe los datos del formulario para actualizar cementerio */
     public function editarUbicacion(){
        $this->_ubicacion->actualizarUbicacion($this->getTexto('idUbicacionUP'), $this->getTexto('cemterioDescansaUP'), $this->getTexto('latitudUbicacionUP'), $this->getTexto('longitudUbicacionUP'), $this->getTexto('descripcionLugarUP'),$this->getTexto('idDefUp'));
        echo $this->verAsignados(); 
    }

    /* Funcion que recibe el id del cementerio a eliminar */
    public function borrarUbicacion(){
        $this->_ubicacion->borrarUbicacion($this->getTexto('idUbicacion'));
        echo $this->verAsignados();
    }



}




?>