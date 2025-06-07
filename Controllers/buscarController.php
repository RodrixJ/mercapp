<?php

class buscarController extends Controller{
    private $_busqueda;

    function __construct()
    {
        parent::__construct();
        $this->_busqueda=$this->loadModel("buscar");
    }

    public function busqueda(){
        $fila=$this->_busqueda->buscarDefuncion($this->getTexto('bus'));
        if(is_array($fila)){
        $tabla='';
        for($i=0;$i<count($fila);$i++){
            $datos=json_encode($fila[$i]);
            $tabla.='
            <tr>
            <td><img src=Views/plantilla/assets/img/'.$fila[$i]['recurso'].' class="img-thumbnail" width="50" height="40"></td>
            <td>'.$fila[$i]['primer_nombre'].' ' . $fila[$i]['segundo_nombre'] . ' ' . $fila[$i]['primer_apellido'] . ' ' . $fila[$i]['segundo_apellido'] . '</td>
            <td>'.$fila[$i]['fecha_nacimiento'].'</td>
            <td>'.$fila[$i]['fecha_ocurrencia'].'</td>
    
            <td>


                <button data-idPersona=' . $fila[$i]['id_defuncion'] . ' data-bs-toggle="modal" data-bs-target="#modalPerfilBuscar" class="btn btn-success btn-circle btBuscarPerfil">
   <i class="fas fa-list"> </i>
   </button>
                 </td>

    
            </tr>';
        }
        echo $tabla;
    
    }
    else{
       
     
    
    }
      
    
      
    
    }

    public function index(){

       
        $this->_view->renderizar('buscar');
    }


    public function cargarPerfil()
  {
    $fila = $this->_busqueda->datosPerfil($this->getTexto('id'));
    $imagenes = $this->_busqueda->datosPerfil($this->getTexto('id'));
    $vista = '';
   if (count($fila) > 0) {
        $vista .= '
 
        <section class="section profile">
      <div class="row">
        <div class="col-xl-4">

          <div class="card">
            <div class="card-body profile-card pt-4 d-flex flex-column align-items-center">

              <img src="' . PLANTILLA . 'assets/img/' . $fila[0]['recurso'] . '" alt="Profile" class="rounded-circle"  >

              <h2>' . $fila[0]['primer_nombre'] . ' ' . $fila[0]['segundo_nombre'] . ' ' . $fila[0]['primer_apellido'] . ' ' . $fila[0]['segundo_apellido'] . '</h2>
              <h3>Se Dedico a: ' . $fila[0]['ocupacion'] . '</h3>
            </div>
          </div>

        </div>

        <div class="col-xl-8">

          <div class="card">
            <div class="card-body pt-3">
              <!-- Bordered Tabs -->
              <ul class="nav nav-tabs nav-tabs-bordered">

                <li class="nav-item">
                  <button class="nav-link active" data-bs-toggle="tab" data-bs-target="#perfil">Acerca De</button>
                </li>

                <li class="nav-item">
                  <button class="nav-link" data-bs-toggle="tab" data-bs-target="#recuerdos">Recuerdos</button>
                </li>

                 

               
              </ul>
              <div class="tab-content pt-2">

                <div class="tab-pane fade show active perfil" id="perfil">
                  <h5 class="card-title">Acerca De</h5>
                  <p class="small fst-italic">En memoria de ' . $fila[0]['primer_nombre'] . ' ' . $fila[0]['segundo_nombre'] . ' ' . $fila[0]['primer_apellido'] . ' ' . $fila[0]['segundo_apellido'] . ', quien partió de este mundo el ' . $fila[0]['fecha_ocurrencia'] . ' a la edad de ' . $fila[0]['edad_cumplida'] . ' años. Nacido el ' . $fila[0]['fecha_nacimiento'] . ' en ' . $fila[0]['nombre_municipio'] . ' Con una ocupación de ' . $fila[0]['ocupacion'] . ', su vida estuvo marcada por su pasión y entrega. En el momento de su fallecimiento, su familia estaba presente para brindarle amor y apoyo. Su descanso final se encuentra en ' . $fila[0]['nombre'] . ', un lugar que refleja la paz y la tranquilidad. Los momentos compartidos, capturados en fotografías y recuerdos compartidos, seguirán viviendo en los corazones de quienes lo amaron.</p>

                  <h5 class="card-title">Datos de Perfil</h5>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Nombre Completo :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['primer_nombre'] . ' ' . $fila[0]['segundo_nombre'] . ' ' . $fila[0]['primer_apellido'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Fecha Nacio :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['fecha_nacimiento'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Fecha Fallecio :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['fecha_ocurrencia'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Lugar Nacio :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['nombre_municipio'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Ocupación :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['ocupacion'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Lugar Descanso :</div>
                    <div class="col-lg-7 col-md-7">Latitud : ' . $fila[0]['latitud'] . ' Longitud : ' . $fila[0]['longitud'] . '</div>
                  </div>

                  <div class="row">
                    <div class="col-lg-5 col-md-5 label fw-bold">Descripcion Lugar de Descanso :</div>
                    <div class="col-lg-7 col-md-7">' . $fila[0]['descripcion_lugar'] . '</div>
                  </div>

                </div>

                 
                

                <div class="tab-pane fade pt-3" id="recuerdos"> ';

                // Bucle a través del arreglo 0magenes
                for ($j = 0; $j < count($imagenes); $j++) {
                   $vista .= '
                    <div class="card mb-3" style="max-width: 540px;">
                        <div class="row g-0">
                            <div class="col-md-4">
                               <a href="' . PLANTILLA . 'assets/img/' . $imagenes[$j]['recurso'] . '" data-fancybox="gallery" data-caption="Recuerdo">

                                <img src="' . PLANTILLA . 'assets/img/' . $imagenes[$j]['recurso'] . '" class="img-fluid rounded-start" style="width:100%" alt="">
                                </a>
                            </div>
                            <div class="col-md-8">
                                <div class="card-body">
                                    <h5 class="card-title">Recuerdo</h5>
                                    <p class="card-text">' . $imagenes[$j]['descripcion_recuerdo'] . '</p>
                                    <p class="card-text"><small class="text-body-secondary">De ' . $imagenes[$j]['fecha_nacimiento'] . ' hasta ' . $imagenes[$j]['fecha_ocurrencia'] . '</small></p>
                                </div>
                            </div>
                        </div>
                    </div>';
                  }

                  $vista .= '
                                  </div> <!-- Fin de #recuerdos -->
                              </div> <!-- Fin de .tab-content -->
                          </div> <!-- Fin de .card-body -->
                      </div> <!-- Fin de .card -->
                  </div> <!-- Fin de .col-xl-8 -->
              </div> <!-- Fin de .row -->
          </section>';
      }
  
      echo $vista; // Imprimir toda la vista al final
  }

   

}

