<!-- ======= Sidebar ======= -->
<aside id="sidebar" class="sidebar">

  <ul class="sidebar-nav" id="sidebar-nav">

    <li class="nav-item">
      <a class="nav-link " href="<?= BASE_URL ?>index">
        <i class="bi bi-grid"></i>
        <span>Dashboard</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" href="<?= BASE_URL ?>mapa">
      <i class="fa-solid fa-map"></i>
        <span>Mapa</span>
      </a>
    </li><!-- End Dashboard Nav -->

     <li class="nav-item">
      <a class="nav-link collapsed" href="<?= BASE_URL ?>propietario">
      <i class="fa-solid fa-user-tie"></i>
        <span>Propietario</span>
      </a>
    </li><!-- End Dashboard Nav -->

       <li class="nav-item">
      <a class="nav-link collapsed" href="<?= BASE_URL ?>tramo">
      <i class="fa-solid fa-store"></i>
        <span>Tramo</span>
      </a>
    </li><!-- End Dashboard Nav -->

       <li class="nav-item">
      <a class="nav-link collapsed" href="<?= BASE_URL ?>producto">
      <i class="fa-solid fa-user-tie"></i>
        <span>Producto</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <li class="nav-item">
      <a class="nav-link collapsed" href="<?= BASE_URL ?>buscar">
      <i class="fa-solid fa-search"></i>
        <span>Buscar</span>
      </a>
    </li><!-- End Dashboard Nav -->

    <?php
    if (Sessiones::getVista('administrador')) {
      ?>

<li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>usuario">
          <i class="fa-solid fa-user"></i>
          <span>Usuario</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>departamento">
        <i class="fa-solid fa-location-pin"></i>
          <span>Departamento</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>municipio">
        <i class="fa-solid fa-mountain-sun"></i>
          <span>Municipio</span>
        </a>
      </li><!-- End Dashboard Nav -->
      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>cementerio">
          <i class="fa-solid fa-cross"></i>
          <span>Cementerio</span>
        </a>
      </li><!-- End Dashboard Nav -->

      

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>categoria">
          <i class="fa-solid fa-list"></i>
          <span>Categoría Defunciones</span>
        </a>
      </li><!-- End Dashboard Nav -->

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>causas">
          <i class="fa-solid fa-disease"></i>
          <span>Causas Defuncioness</span>
        </a>
      </li><!-- End Dashboard Nav -->



      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>defunciones">
          <i class="fa-solid fa-skull"></i>
          <span>Defunciones</span>
        </a>
      </li><!-- End Dashboard Nav -->

     
      <li class="nav-item">
      <a class="nav-link collapsed" data-bs-target="#forms-nav" data-bs-toggle="collapse" href="#">
      <i class="fa-solid fa-location-dot"></i><span>Ubicaciones Descanso</span><i class="bi bi-chevron-down ms-auto"></i>
      </a>
      <ul id="forms-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
        <li>
          <a href="<?= BASE_URL ?>ubicacion">
            <i class="bi bi-circle"></i><span>Sin Asignar</span>
          </a>
        </li>
        <li>
        <a href="<?= BASE_URL ?>ubicacion/asignados">
            <i class="bi bi-circle"></i><span>Asignados</span>
          </a>
        </li>
       
      </ul>
    </li>

    <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>servicios">
        <i class="fa-solid fa-bell-concierge"></i>
          <span>Servicios</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>operario">
        <i class="fa-solid fa-id-card-clip"></i>
          <span>Operarios</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>proveedor">
        <i class="fa-solid fa-person-digging"></i>
          <span>Proveedor de Servicios</span>
        </a>
      </li>

      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>respaldo">
        <i class="fa-solid fa-floppy-disk"></i>
          <span>Respaldar BD</span>
        </a>
      </li>
      
    
      
      <!-- End Dashboard Nav -->
    
    
    
    
    
    <!-- End Forms Nav -->






      <!-- End Dashboard Nav -->
    <?php } ?>

    <?php
    if (Sessiones::accesoVista('familiar')) {
      ?>

    <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>recuerdo">
        <i class="fa-solid fa-people-roof"></i>
          <span>Recuerdo</span>
        </a>
      </li><!-- End Dashboard Nav -->


      <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>solicitar">
        <i class="fa-solid fa-money-bill"></i>
          <span>Solicitar Servicio</span>
        </a>
      </li><!-- End Dashboard Nav -->
      <?php } ?>


      <?php
    if (Sessiones::accesoVista('operario')) {
      ?>

    <li class="nav-item">
        <a class="nav-link collapsed" href="<?= BASE_URL ?>solicitud">
        <i class="fa-regular fa-handshake"></i>
          <span>Solicitudes</span>
        </a>
      </li><!-- End Dashboard Nav -->


      
      <?php } ?>


    <?php
    if (Sessiones::getClave('autenticado')) {
      echo '
      <li class="nav-item">
        <a class="nav-link collapsed" href="' . BASE_URL . 'login/salir">
        <i class="fa-solid fa-right-from-bracket"></i>
          <span>Salir</span>
        </a>
      </li>';
    } else {
      echo '
      <li class="nav-item">
        <a class="nav-link collapsed" href="' . BASE_URL . 'login">
        <i class="fa-solid fa-right-to-bracket"></i>
          <span>Ingresar</span>
        </a>
      </li>';
    }
    ?>

   

    

  </ul>

</aside><!-- End Sidebar-->