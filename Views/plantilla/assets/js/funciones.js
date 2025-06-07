$(function () {

    /* Inicializando dataTable */
    inicializarDataTable();

    /* Funciones para capturar la ruta en la que se encuentra y proporcionar la clase active en el menu */

    var activeUrl = window.location.pathname;

    // Selecciona el enlace activo
    var activeLink = $('a[href*="' + activeUrl + '"]');

    // Quita la clase 'collapsed' del enlace activo
    activeLink.removeClass('collapsed');

    // Agrega 'collapsed' a los demás enlaces
    $(".nav-link").not(activeLink).addClass('collapsed');

    $(".nav-item").click(function () {
        var callItem = $(this);

        // Quita la clase 'active' de otros elementos y agrega a 'callItem'
        $(".nav-item").not(callItem).removeClass('active');
        callItem.addClass('active');

        // Remueve 'collapsed' del enlace clicado y lo agrega a los demás
        var clickedLink = callItem.find('a');
        $(".nav-link").addClass('collapsed');
        clickedLink.removeClass('collapsed');
    });
    /* Inicializacion del mapa de leaflet */


    $("#municipio").prop("disabled", true);


    /* funciones para comprobar no se registren usuarios repetidos */

    $("#nombre").on("keyup",function(){
        if($('#nombre').val()!= ""){
          $("#result").html('checking...');
          
          var bus=$("#nombre").val();
            $.ajax({
                type: "POST",
                url: "usuario/verificar/",
                data:{'bus':bus},
                success : function(data){
                  $("#result").html(data);
      
                 
      
      
                }
            });
        }
      });

      /* funciones para comprobar la complejidad de la clave */

      $('#clave').complexify({},function(valid,complexify){
        var clave=$("#clave").val();
        var clave2=$("#repetir").val();
        
        $(".progress-bar").css('width',complexify+'%');
        if(valid){
          if(clave2===clave)
          $("#enviar").prop( "disabled", false );
          $(".progress-bar").addClass('bg-success').removeClass('bg-danger');
          $("#enviar").attr( 'estado', true );
        } 
        else{
          $("#enviar").prop( "disabled", true );
          $(".progress-bar").addClass('bg-danger').removeClass('bg-success');
          $("#enviar").attr('estado',false );
        }
            });

            $("#repetir").on("keyup", function () {
                var clave = $("#clave").val();
                var clave2 = $("#repetir").val();
            
                if (clave === clave2 && clave !== '') {
                    $("#enviar").prop("disabled", false);
                } else {
                    $("#enviar").prop("disabled", true);
                }
            });

      

    /* funciones cementerio */

    $('#departamento').on("change", function () {
        let idDepartamento = $('#departamento').val();
        console.log(idDepartamento);
        $.ajax({
            url: '../cementerio/cargarMunicipio',
            type: 'post',
            data: { 'idDepartamento': idDepartamento },
            success: function (respuesta) {
                $("#municipio").prop("disabled", false);
                $("#municipio").html(respuesta);
                console.log(respuesta);
            }
        });
    });

    /* funciones agregar cementerio */
    $('#formAgregarCementerio').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: '../cementerio/agregarCementerio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                console.log(respuesta);
                $('#formAgregarCementerio')[0].reset();
                Swal.fire({
                    title: "Se agrego cementerio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* Funcion para enviar los datos y cargarlos en el formilario de actualizar */
    $("#table").on("click", ".btnEditarCementerio", function () {

        let datos = JSON.parse($(this).attr('data-cementerio'));

        // Guarda los datos en sessionStorage
        sessionStorage.setItem('datosCementerio', JSON.stringify(datos));

        // Redirige a la nueva vista
        window.location.href = 'http://localhost/happymemories/cementerio/actualizar';
    });

    var datos = sessionStorage.getItem('datosCementerio');

    if (datos) {
        datos = JSON.parse(datos);
        console.log('Datos recibidos:', datos);
        $("#idCementerioUp").val(datos['id_cementerio']);
        $("#nombreUp").val(datos['nombre']);
        $("#latitudUp").val(datos['latitud']);
        $("#longitudUp").val(datos['longitud']);
        $("#capacidadUp").val(datos['capacidad']);
        $("#tipoUp").val(datos['tipo']);
        $("#horaAperturaUp").val(datos['hora_apertura']);
        $("#horaCierreUp").val(datos['hora_cierre']);
        $("#departamentoUp").val(datos['departamento_id_departamento']);
        $("#municipioUp").prop("disabled", true);

        // Define el valor y el texto de la nueva opción
        var valorNuevo = datos['municipio_id_municipio'];
        var textoNuevo = datos['nombre_municipio'];

        // Crea una nueva opción
        var nuevaOpcion = $('<option></option>')
            .val(valorNuevo)
            .text(textoNuevo);
        // Añade la nueva opción al select
        $('#municipioUp').append(nuevaOpcion);


        // Elimina los datos de sessionStorage si ya no los necesitas
        sessionStorage.removeItem('datosCementerio');
    } else {
        console.log('No se recibieron datos.');
    }
    /* Funcion para cargar municipios segun el departamento seleccionado */
    $('#departamentoUp').on("click", function () {
        if ($('#departamentoUp').val() != 0) {

            let idDepartamento = $('#departamentoUp').val();
            console.log(idDepartamento);
            $.ajax({
                url: '../cementerio/cargarMunicipio',
                type: 'post',
                data: { 'idDepartamento': idDepartamento },
                success: function (respuesta) {
                    $("#municipioUp").prop("disabled", false);
                    $("#municipioUp").html(respuesta);
                    console.log(respuesta);
                }
            });
        }
    });

    /* funciones Enviar datos actualizados de cementerio */
    $('#formActualizarCementerio').submit(function (e) {
        e.preventDefault();
        $("#municipioUp").prop("disabled", false);
        $.ajax({
            url: '../cementerio/actualizarCementerio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                console.log(respuesta);
                $('#formActualizarCementerio')[0].reset();
                Swal.fire({
                    title: "Se Actualizo cementerio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });




    /* funcion borrar cementerio */
    $("#table").on("click", ".btBorrarCementerio", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idCementerio = $(this).attr('data-borrarCementerio');

                $.ajax({
                    url: 'cementerio/borrarCementerio/',
                    type: "POST",
                    data: { 'idCementerio': idCementerio },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });

    /* ------------------------------
       ------------------------------
         *   Funciones usuario   *
       ------------------------------
       ------------------------------
    */





    /* funciones agregar usuario */
    $('#formAgregarUsuario').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'usuario/agregarUsuario',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarUsuario').modal('hide');
                $('#formAgregarUsuario')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego cementerio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

      /* funcion borrar usuario */
      $("#table").on("click", ".btBorrarUsuario", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idU = $(this).attr('data-borrarUsuario');

                $.ajax({
                    url: 'usuario/borrarUsuario/',
                    type: "POST",
                    data: { 'idU': idU },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });

    /* ------------------------------
        ------------------------------
          *   Funciones categoria   *
        ------------------------------
        ------------------------------
     */



     /* funciones agregar propietario */
    $('#agregarPropietario').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'propietario/agregarPropietario',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarPropietario').modal('hide');
                $('#agregarPropietario')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego Propietario!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    

    /* funciones agregar propietario */
    $('#formAgregarTramo').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'tramo/agregarTramo',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarTramo').modal('hide');
                $('#formAgregarTramo')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego Tramo!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

     /* funciones agregar producto con imagen */
    $('#formAgregarProducto').submit(function (e) {
        e.preventDefault();
        var extension = $("#imagen").val().split('.').pop().toLowerCase();;
        console.log(extension);
        if (extension != '') {
            if (jQuery.inArray(extension, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
                alert("Invalid Image File");
                $('#imagen').val('');
                return false;
            }
        }
        $.ajax({
            url: 'producto/agregarProducto',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarProducto').modal('hide');
                $('#formAgregarProducto')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego eñ producto!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });



    /* funciones agregar usuario */
    $('#formAgregarCategoria').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'categoria/agregarCategoria',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarCategoria').modal('hide');
                $('#formAgregarCategoria')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego categoria!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* funciones cargar los datos en el modal actualizar categoria */
    $("#table").on("click", ".btnEditarCategoria", function () {
        $('#modalActualizarCategoria').modal({ backdrop: 'static', keyboard: false });
        var datos = JSON.parse($(this).attr('data-categoria'));
        $("#idCategoriaUp").val(datos['id']);
        $("#nombreCategoriaUp").val(datos['nombre_categoria']);
    });



    /* funciones actualizar datos de la categoria */
    $('#formActualizarCategoria').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'categoria/actualizarCategoria',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalActualizarCategoria').modal('hide');
                $('#formActualizarCategoria')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se actualizo categoria!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* funcion borrar categoria */
    $("#table").on("click", ".btBorrarCategoria", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idCategoria = $(this).attr('data-borrarCategoria');

                $.ajax({
                    url: 'categoria/borrarCategoria/',
                    type: "POST",
                    data: { 'idCategoria': idCategoria },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        $('#table').DataTable({
                            dom: 'Bfrtip',
                            buttons: [
                                'copy', 'excel', 'pdf', 'print'
                            ],
                            language: {
                                url: 'https://cdn.datatables.net/plug-ins/2.1.5/i18n/es-MX.json',
                            },
                            responsive: true
                        });
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });

    /* ------------------------------
    ------------------------------
      *   Funciones Causas   *
    ------------------------------
    ------------------------------
 */


    /* funciones agregar enfermedades */
    $('#formAgregarCausa').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'causas/agregarCausa',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarCausa').modal('hide');
                $('#formAgregarCausa')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de enfermedad!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* funciones cargar los datos en el modal actualizar ENFERMEDAD */
    $("#table").on("click", ".btnEditarCausa", function () {
        $('#modalEditarCausa').modal({ backdrop: 'static', keyboard: false });
        var datos = JSON.parse($(this).attr('data-causa'));
        $("#idCausa").val(datos['id']);
        $("#codigoCIEUP").val(datos['codigo']);
        $("#nombreCategoriaUP").val(datos['categoria_id']);
        $("#descripcionUP").val(datos['descripcion']);

    });



    /* funcion que envia los datos del formulario actualizar datos de la enfermedad */
    $('#formEditarEnfermedad').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'causas/actualizarCausa',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalEditarCausa').modal('hide');
                $('#formEditarEnfermedad')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se actualizo categoria!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* funcion borrar enfermedad */
    $("#table").on("click", ".btBorrarCausa", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idCausa = $(this).attr('data-borrarCausa');

                $.ajax({
                    url: 'causas/borrarCausa/',
                    type: "POST",
                    data: { 'idCausa': idCausa },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });

    /* ------------------------------
      ------------------------------
        *   Funciones Departamentos  *
      ------------------------------
      ------------------------------
   */


    /* funciones agregar Departamento */
    $('#formAgregarDepartamento').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'departamento/agregarDepartamento',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarDepartamento').modal('hide');
                $('#formAgregarDepartamento')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de enfermedad!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* funciones cargar los datos en el modal actualizar Departamento */
    $("#table").on("click", ".btnEditarDepartamento", function () {
        $('#modalActualizarDepartamento').modal({ backdrop: 'static', keyboard: false });
        var datos = JSON.parse($(this).attr('data-departamento'));
        $("#idDepartamentoUp").val(datos['id_departamento']);
        $("#nombreDepartamentoUp").val(datos['nombre_departamento']);
    });



    /* funcion que envia los datos del formulario actualizar datos de la departamento */
    $('#formActualizarDepartamento').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'departamento/actualizarDepartamento',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalActualizarDepartamento').modal('hide');
                $('#formActualizarDepartamento')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se actualizo categoria!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* funcion borrar departamento */
    $("#table").on("click", ".btBorrarDepartamento", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idDepartamento = $(this).attr('data-borrarDepartamento');

                $.ajax({
                    url: 'departamento/borrarDepartamento/',
                    type: "POST",
                    data: { 'idDepartamento': idDepartamento },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });

    /* ------------------------------
       ------------------------------
         *   Funciones Municipios  *
       ------------------------------
       ------------------------------
    */


    /* funciones agregar Municipio */
    $('#formAgregarMunicipio').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: 'municipio/agregarMunicipio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarMunicipio').modal('hide');
                $('#formAgregarMunicipio')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de Municipio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* funciones cargar los datos en el modal actualizar Municipio */
    $("#table").on("click", ".btnEditarMunicipio", function () {
        $('#modalActualizarMunicipio').modal({ backdrop: 'static', keyboard: false });
        var datos = JSON.parse($(this).attr('data-municipio'));
        $("#idMunicipio").val(datos['id_municipio']);
        $("#departamentoUP").val(datos['departamento_id_departamento']);
        $("#nombreMunicipioUP").val(datos['nombre_municipio']);

    });



    /* funcion que envia los datos del formulario actualizar datos de la municipio */
    $('#formEditarMunicipio').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'municipio/actualizarMunicipio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalActualizarMunicipio').modal('hide');
                $('#formEditarMunicipio')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se actualizo categoria!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* funcion borrar departamento */
    $("#table").on("click", ".btBorrarMunicipio", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idMunicipio = $(this).attr('data-borrarMunicipio');

                $.ajax({
                    url: 'municipio/borrarMunicipio/',
                    type: "POST",
                    data: { 'idMunicipio': idMunicipio },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });


    /* ------------------------------
       ------------------------------
         *   Funciones Defunciones  *
       ------------------------------
       ------------------------------
    */

    /* funciones agregar cementerio */
    $('#formAgregarDefuncion').submit(function (e) {
        e.preventDefault();
        $('#edadCumplida').prop('disabled', false);
        $.ajax({
            url: '../defunciones/agregarDefuncion',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                console.log(respuesta);
                $('#formAgregarDefuncion')[0].reset();
                $('#edadCumplida').prop('disabled', true);
                Swal.fire({
                    title: "Se agrego Defunción!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });





    /* ------------------------------
       ------------------------------
         *   Funciones Familiar Recuerdo  *
       ------------------------------
       ------------------------------
    */




    /* funciones cargar los datos en el modal actualizar Municipio */
    $("#table").on("click", ".btnAgregarRecuerdo", function () {
        var datos = JSON.parse($(this).attr('data-recuerdo'));
        $("#nombreCompleto").val(datos['primer_nombre'] + ' ' + datos['segundo_nombre'] + ' ' + datos['primer_apellido'] + ' ' + datos['segundo_apellido']);
        $("#fechaNacimiento").val(datos['fecha_nacimiento']);
        $("#edad").val(datos['edad_cumplida']);
        $("#sexo").val(datos['sexo']);
        $("#nacionalidadDifunto").val(datos['nacionalidad']);
        $("#ocupacionDifunto").val(datos['ocupacion']);
        $("#fechaDefuncion").val(datos['fecha_ocurrencia']);
        $("#horaDefuncion").val(datos['hora_defuncion']);
        $("#idDefu").val(datos['id_defuncion']);

    });


    $("#formAgregarRecuerdo").on("submit", function (e) {

        // Obtener el archivo
        var fileInput = document.getElementById('recurso');
        var file = fileInput.files[0]; // Accede al primer archivo

        // Verificar si se seleccionó un archivo
        if (file) {
            // Obtener la extensión del archivo
            var extension = file.name.split('.').pop().toLowerCase();

            // Verificar la extensión
            if (jQuery.inArray(extension, ['gif', 'png', 'jpg', 'jpeg', 'mp4']) == -1) {
                alert("Archivo no válido. Solo se permiten imágenes (gif, png, jpg, jpeg) y videos (mp4).");
                fileInput.value = ''; // Limpiar el input
                return false;
            }

            // Verificar el tamaño del archivo
            if (file.size > 10 * 1024 * 1024) { // 10 MB en bytes
                alert("El archivo es demasiado grande. El tamaño máximo permitido es de 10 MB.");
                fileInput.value = ''; // Limpiar el input
                return false;
            }
        } else {
            alert("Por favor, selecciona un archivo.");
            return false;
        }



        e.preventDefault();
        $.ajax({
            url: 'recuerdo/insertarRecuerdo/',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                console.log(respuesta);
                if (respuesta == true) {
                    $('#formAgregarRecuerdo')[0].reset();
                    $('#modalAgregarRecuerdo').modal('hide');


                    Swal.fire(
                        'Se Agrego el Recuerdo con exito',
                        'en el sistema',
                        'success'
                    )
                }
                else {
                    Swal.fire(
                        'Error al añadir el archivo',
                        'en el sistema',
                        'error'
                    )
                }





            }
            , error: function () {
                console.log('Error');
            }



        });



    });

    /* ------------------------------
       ------------------------------
         *   Funciones Ubicacion Descanso  *
       ------------------------------
       ------------------------------
    */

    /* funciones cargar los datos en el modal Asignar Funcion Descanso*/
    $("#table").on("click", ".btnAgregarUbicacion", function () {
        var datos = JSON.parse($(this).attr('data-ubicacion'));
        $("#nombreCompleto").val(datos['primer_nombre'] + ' ' + datos['segundo_nombre'] + ' ' + datos['primer_apellido'] + ' ' + datos['segundo_apellido']);
        $("#cedula").val(datos['cedula']);

        $("#edadFallecio").val(datos['edad_cumplida']);
        $("#imgRecuerdo").val(datos['sexo']);
        $("#imgRecuerdo").attr("src", 'Views/plantilla/assets/img/' + datos['recurso']);


        $("#fechaNacioU").val(datos['fecha_nacimiento']);
        $("#fechaFallecio").val(datos['fecha_ocurrencia']);
        $("#sexoFallecio").val(datos['sexo']);
        $("#horaDefuncion").val(datos['hora_defuncion']);
        $("#idDifunto").val(datos['id_defuncion']);

    });


    /* funciones agregar Ubicacion */
    $('#formAgregarUbicacion').submit(function (e) {
        e.preventDefault();

        var extension = $("#fotoUbicacion").val().split('.').pop().toLowerCase();
        console.log(extension);
        if (extension != '') {
            if (jQuery.inArray(extension, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
                alert("Invalid Image File");
                $('#fotoUbicacion').val('');
                return false;
            }
        }

        $.ajax({
            url: 'ubicacion/asignarUbicacion',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAsignarUbicacion').modal('hide');
                $('#formAgregarUbicacion')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de Municipio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* funciones cargar los datos en el modal Editar Asignacion Descanso*/
    $("#table").on("click", ".btnEditarAsignacion", function () {
        var datos = JSON.parse($(this).attr('data-asignado'));
        console.log(datos);
        $("#nombreCompletoUP").val(datos['primer_nombre'] + ' ' + datos['segundo_nombre'] + ' ' + datos['primer_apellido'] + ' ' + datos['segundo_apellido']);
        $("#cedulaUP").val(datos['cedula']);

        $("#edadFallecioUP").val(datos['edad_cumplida']);
        $("#sexoFallecioUP").val(datos['sexo']);
        $("#imgRecuerdoUP").attr("src", '../Views/plantilla/assets/img/' + datos['imagen_descanso']);


        $("#fechaNacioUUP").val(datos['fecha_nacimiento']);
        $("#fechaFallecioUP").val(datos['fecha_ocurrencia']);
        $("#sexoFallecioUP").val(datos['sexo']);

        $("#idUbicacionUP").val(datos['id_ubicacion']);
        $("#cemterioDescansaUP").val(datos['cementerio_id_cementerio']);
        $("#latitudUbicacionUP").val(datos['latitud']);
        $("#longitudUbicacionUP").val(datos['longitud']);
        $("#descripcionLugarUP").val(datos['descripcion_lugar']);
        $("#idDefUp").val(datos['defuncion_id_defuncion']);

    });

    /* funciones actulizar asignacion ubicacion */
    $('#formActualizarUbicacion').submit(function (e) {
        e.preventDefault();

        $.ajax({
            url: '../ubicacion/editarUbicacion',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalEditarAsignacion').modal('hide');
                $('#formActualizarUbicacion')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de Municipio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });

    /* funcion borrar ubicacion */
    $("#table").on("click", ".btBorrarUbicacion", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "No podrá recuperar los datos!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idUbicacion = $(this).attr('data-borrarUbicacion');

                $.ajax({
                    url: '../ubicacion/borrarUbicacion/',
                    type: "POST",
                    data: { 'idUbicacion': idUbicacion },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Borrado',
                            'El registro a sido eliminado',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });


    /* ------------------------------
        ------------------------------
          *   Funciones Mapa Cargar Perfiles  *
        ------------------------------
        ------------------------------
     */



    $("#map").on("click", ".btnVerPerfil", function (e) {
        let id = JSON.parse($(this).attr('data-verPerfil'));
        e.preventDefault();
        $.ajax({
            url: 'mapa/cargarPerfil/',
            type: 'post',
            data: { 'id': id },
            success: function (respuesta) {

                console.log(respuesta);
                $('#modalPerfil .modal-body').html(respuesta);


            }




        });



    });


    /* ------------------------------
       ------------------------------
         *   Funciones Cargar Perfiles en Buscar*
       ------------------------------
       ------------------------------
    */



    $("#table").on("click", ".btBuscarPerfil", function (e) {



        let id = JSON.parse($(this).attr('data-idPersona'));
        e.preventDefault();
        $.ajax({
            url: 'buscar/cargarPerfil/',
            type: 'post',
            data: { 'id': id },
            success: function (respuesta) {

                console.log(respuesta);
                $('#modalPerfilBuscar .modal-body').html(respuesta);


            }




        });



    });

    /* ------------------------------
        ------------------------------
          *   Funciones Servicios  *
        ------------------------------
        ------------------------------
     */




    /* funciones agregar Servicios */
    $('#formAgregarServicio').submit(function (e) {
        e.preventDefault();
        var extension = $("#imagenServicio").val().split('.').pop().toLowerCase();;
        console.log(extension);
        if (extension != '') {
            if (jQuery.inArray(extension, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
                alert("Invalid Image File");
                $('#imagenServicio').val('');
                return false;
            }
        }
        $.ajax({
            url: 'servicios/agregarServicio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarServicio').modal('hide');
                $('#formAgregarServicio')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de Municipio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });



    /* ------------------------------
        ------------------------------
          *   Funciones operarios  *
        ------------------------------
        ------------------------------
     */




    /* funciones agregar operario */
    $('#formAgregarOperario').submit(function (e) {
        e.preventDefault();
        var extension = $("#fotoOperario").val().split('.').pop().toLowerCase();;
        console.log(extension);
        if (extension != '') {
            if (jQuery.inArray(extension, ['gif', 'png', 'jpg', 'jpeg']) == -1) {
                alert("Invalid Image File");
                $('#fotoOperario').val('');
                return false;
            }
        }
        $.ajax({
            url: 'operario/agregarOperario',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarOperario').modal('hide');
                $('#formAgregarOperario')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro de Operario!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* ------------------------------
       ------------------------------
         *   Funciones Proveedor de servicios  *
       ------------------------------
       ------------------------------
    */



    /* funciones agregar operario */
    $('#formAgregarProveedor').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'proveedor/agregarProveedor',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalAgregarProveedor').modal('hide');
                $('#formAgregarProveedor')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se agrego registro deL Proveedor!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* ------------------------------
        ------------------------------
          *   Funciones solicitar servicios Familiar *
        ------------------------------
        ------------------------------
     */

    /* funciones agregar solicitud de servicio */
    $('#formSolicitarServicio').submit(function (e) {
        e.preventDefault();
        $.ajax({
            url: 'solicitar/solicitudServicio',
            type: 'post',
            data: new FormData(this),
            contentType: false,
            processData: false,
            success: function (respuesta) {
                $('#modalSolicitarServicio').modal('hide');
                $('#formSolicitarServicio')[0].reset();
                $("#table").DataTable().destroy();
                $("#table tbody").html(respuesta);
                inicializarDataTable();
                Swal.fire({
                    title: "Se registro su solicitud de Servicio!",
                    text: "con exito!",
                    icon: "success"
                });

            }


        });
    });


    /* ------------------------------
      ------------------------------
        *   Funciones solicitud operario *
      ------------------------------
      ------------------------------
   */

    /* funcion borrar ubicacion */
    $("#table").on("click", ".btCancelarSolicitud", function () {
        Swal.fire({
            title: 'Estas seguro?',
            text: "Desea Cancelar la Solicitud!",
            icon: 'warning',
            confirmButtonColor: '#d9534f',
            cancelButtonColor: '#428bca',
            showCloseButton: true,
            showCancelButton: true,
            confirmButtonText: 'Sí, Eliminarlo!',
            cancelButtonText: 'No, cancelar',
            reverseButtons: true
        }).then((result) => {
            if (result.isConfirmed) {
                var idSolicitud = $(this).attr('data-borrarSolicitud');

                $.ajax({
                    url: 'solicitud/cancelarSolicitud/',
                    type: "POST",
                    data: { 'idSolicitud': idSolicitud },
                    success: function (respuesta) {
                        $("#table").DataTable().destroy();
                        $("#table tbody").html(respuesta);
                        inicializarDataTable();
                        Swal.fire(
                            'Cancelado',
                            'La Solicitud a sido Cancelada',
                            'success'
                        )


                    }
                });






            }
            else if (
                result.dismiss === Swal.DismissReason.cancel
            ) {
                Swal.fire(
                    'cancelado',
                    'el registro esta a salvo',
                    'error'

                )

            }

        });


    });


    /* ------------------------------
        ------------------------------
          *   Funciones generar QR *
        ------------------------------
        ------------------------------
     */

    /* funcion borrar ubicacion */
    $("#table").on("click", ".btGenerarQr", function (e) {

        e.preventDefault();
        var idQR = $(this).attr('data-qr');

        $.ajax({
            url: 'defunciones/generarQR/',
            type: "POST",
            data: { 'idQR': idQR },
            success: function (respuesta) {
                console.log(respuesta);

               

                // Now, show the QR code in the modal
                var qrImagePath = "/happymemories/Views/plantilla/assets/qr/defuncion_" + idQR + ".png";
                $("#qrImage").attr("src", qrImagePath);

                // Open the modal
                $('#qrModal').modal('show');
            },
            error: function () {
                Swal.fire({
                    title: "Error",
                    text: "No se pudo generar el QR.",
                    icon: "error"
                });
            }




        });

    });















});




function ocultarPass(elemento, icono) {
    let input = document.getElementById(elemento);
    if (input.type === "password") {
        input.type = "text";
        icono.classList.remove("fa-eye");
        icono.classList.add("fa-eye-slash");
    } else {
        input.type = "password";
        icono.classList.remove("fa-eye-slash");
        icono.classList.add("fa-eye");
    }
}

$("#municipioOrigen").prop("disabled", true);

/* funciones defunciones departamento nacimiento carga los municipios */

$('#departamentoOrigen').on("change", function () {
    let idDepartamento = $('#departamentoOrigen').val();
    console.log(idDepartamento);
    $.ajax({
        url: '../defunciones/cargarMunicipio',
        type: 'post',
        data: { 'idDepartamento': idDepartamento },
        success: function (respuesta) {
            $("#municipioOrigen").prop("disabled", false);
            $("#municipioOrigen").html(respuesta);
            console.log(respuesta);
        }
    });
});



/* funciones defunciones departamento defuncion carga los municipios */
$("#municipioDefuncion").prop("disabled", true);
$('#departamentoDefuncion').on("change", function () {
    let idDepartamento = $('#departamentoDefuncion').val();
    console.log(idDepartamento);
    $.ajax({
        url: '../defunciones/cargarMunicipio',
        type: 'post',
        data: { 'idDepartamento': idDepartamento },
        success: function (respuesta) {
            $("#municipioDefuncion").prop("disabled", false);
            $("#municipioDefuncion").html(respuesta);
            console.log(respuesta);
        }
    });
});


/* Funcion para calcular edad automaticamente defuncion*/
$('#fechaNacio, #fechaDefuncion').on('change', function () {
    const fechaNacio = $('#fechaNacio').val();
    const fechaDefuncion = $('#fechaDefuncion').val();

    if (fechaNacio && fechaDefuncion) {
        const edad = calcularEdad(fechaNacio, fechaDefuncion);
        $('#edadCumplida').val(edad);
    } else {
        $('#edadCumplida').val('');
    }
});

function calcularEdad(fechaNac, fechaDef) {
    const nacimiento = new Date(fechaNac);
    const defuncion = new Date(fechaDef);
    let edad = defuncion.getFullYear() - nacimiento.getFullYear();
    const m = defuncion.getMonth() - nacimiento.getMonth();

    // Ajustar la edad si el cumpleaños no ha ocurrido aún en el año de la defunción
    if (m < 0 || (m === 0 && defuncion.getDate() < nacimiento.getDate())) {
        edad--;
    }

    return edad;
}
$("#edadCumplida").prop("disabled", true);




// Inicializacion de select 2 para cargar las causas
$('.js-example-basic-single').select2();


$('#cemterioDescansa').select2({
    dropdownParent: $('#modalAsignarUbicacion'),
    theme: "classic" // Asegúrate de que se muestre dentro del modal
});

$('#horaDefuncion').change(function () {
    console.log($('#horaDefuncion').val());
});



/* funciones para cargar resultados segun la busqueda */


$("#buscar").on("keyup", function () {
    var bus = $("#buscar").val();
    if (bus.length >= 3) {
        console.log(bus);
        $.ajax({
            url: "buscar/busqueda/",
            type: 'POST',
            data: { 'bus': bus },
            success: function (resultado) {
                $("#table").DataTable().destroy();
                $("#table tbody").html(resultado);

                inicializarDataTable();

            }
        });
    }
    else if (bus.length == 0) {
        $("#table").DataTable().destroy();
        $("#table tbody").empty();
        inicializarDataTable();
    }



});



function inicializarDataTable() {
    /* Inicializacion del dataTable con traducciones botones de imprimir excel y generar pdf, ademas del responsive */
    $('#table').DataTable({
        dom: 'Bfrtip',
        buttons: [
            'copy', 'excel', 'pdf', 'print'
        ],
        language: {
            url: 'https://cdn.datatables.net/plug-ins/2.1.5/i18n/es-MX.json',
        },
        responsive: true

    });

}


Fancybox.bind("[data-fancybox]", {
    // Your custom options
});
// Opciones adicionales, si las necesitas

