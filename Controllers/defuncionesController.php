<?php

include_once ROOT.'Views'.DS.'plantilla'.DS.'phpqrcode'.DS.'qrlib.php';
class defuncionesController extends Controller
{
    private $_defunciones;

    function __construct()
    {
        parent::__construct();
        $this->_defunciones = $this->loadModel("defunciones");
    }
 
    public function verDefunciones()
    {

        $fila = $this->_defunciones->obtenerDefunciones();
        $tabla = '';
        for ($i = 0; $i < count($fila); $i++) {
            $datos = json_encode($fila[$i]);
            $tabla .= '
          <tr>
          <td>' . $fila[$i]['id_defuncion'] . '</td>
          <td>' . $fila[$i]['primer_nombre'] . ' ' . $fila[$i]['segundo_nombre'] . ' ' . $fila[$i]['primer_apellido'] . ' ' . $fila[$i]['segundo_apellido']. '</td>
          <td>' . $fila[$i]['fecha_nacimiento'] . '</td>
          <td>' . $fila[$i]['fecha_ocurrencia'] . '</td> 
          <td>
          <button data-cementerio=\'' . $datos . '\' " class="btn btn-info btn-circle btnEditarCementerio">
            <i class="fas fa-info-circle"> </i>
            </button>
   <button data-borrarCementerio=' . $fila[$i]['id_defuncion'] . ' class="btn btn-danger btn-circle btBorrarCementerio">
   <i class="fas fa-trash"> </i>
   </button>

   <button data-qr=' . $fila[$i]['id_defuncion'] . ' class="btn btn-success btn-circle btGenerarQr">
   <i class="fa-solid fa-qrcode"></i>
   </button>

          </td>
  
          </tr>';

        }

        return $tabla;


    }

    public function generarQR()
    {
        $idDefuncion=$this->getTexto('idQR');
        var_dump($idDefuncion);



        $qrData = $idDefuncion; // The URL to be encoded
    $qrFilePath = 'C:/wamp64/www/happymemories/Views/plantilla/assets/qr/defuncion_' . $idDefuncion . '.png'; // Local file path

        // Ensure the directory exists before saving the QR code
        if (!is_dir(PLANTILLA . 'assets/qr/')) {
            mkdir(PLANTILLA . 'assets/qr/', 0777, true); // Create the directory if it doesn't exist
        }
    
        // Generate the QR code only if it doesn't already exist
        if (!file_exists($qrFilePath)) {
            QRcode::png($qrData, $qrFilePath, QR_ECLEVEL_L, 10);
        }

        
       
    }

    public function index()
    {


        $this->_view->tabla = $this->verDefunciones();

        Sessiones::acceso('administrador');
        $this->_view->renderizar('defunciones');
    }

    public function agregar()
    {
        /* Mandando los departamentos a el formulario de agregar municipio */
        $fila = $this->_defunciones->obtenerDepartamento();
        $datos = '<option value="0">Seleccione Departamento</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_departamento'] . '">' . $fila[$i]['nombre_departamento'] . '</option>';
        }
        $this->_view->departamentos = $datos;

        $this->_view->causas = $this->cargarCausas();

        $this->_view->renderizar('agregar');
    }



    public function cargarMunicipio(){
        $fila = $this->_defunciones->obtenerMunicipio($this->getTexto('idDepartamento'));
        $datos = '<option value="0">Seleccione Municipio</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_municipio'] . '">' . $fila[$i]['nombre_municipio'] . '</option>';
        }
        echo $datos;
    }

    public function cargarCausas(){
        $fila = $this->_defunciones->obtenerCausas();
        $datos = '<option value="0">Seleccione Causa</option>';

        for ($i = 0; $i < count($fila); $i++){
            $datos .= '<option value="' . $fila[$i]['id_causa'] . '">' . $fila[$i]['codigo'] . '  - ' . $fila[$i]['descripcion'] . '</option>';

        }
        return $datos;
    }


    /* Funcion que recibe los datos del formulario para agregar cementerio */
    public function agregarDefuncion(){
    $this->_defunciones->insertarDefuncion($this->getTexto('pNombre'),$this->getTexto('sNombre'),
   $this->getTexto('pApellido'),$this->getTexto('sApellido'),
   $this->getTexto('cedula'),$this->getTexto('etnia'),
   $this->getTexto('municipioOrigen'),$this->getTexto('fechaNacio'),$this->getTexto('edadCumplida'),$this->getTexto('sexoDifunto'),$this->getTexto('nacionalidad'),$this->getTexto('estadoCivil'),$this->getTexto('conyugue'),$this->getTexto('ocupacion'),$this->getTexto('fechaDefuncion'),$this->getTexto('municipioDefuncion'),$this->getTexto('causa'),$this->getTexto('horaDefuncion')
   ,$this->getTexto('nombreFamiliar'),$this->getTexto('sexoFamiliar'),$this->getTexto('correoFamiliar'),$this->getTexto('userFamiliar'),$this->getTexto('claveFamiliar'));
    }

   

}




?>