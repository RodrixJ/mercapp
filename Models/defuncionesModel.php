<?php

class defuncionesModel extends Model
{

    public function obtenerDefunciones()
    {
        return $this->_db->query("SELECT 
    id_defuncion,
    primer_nombre, 
    segundo_nombre, 
    primer_apellido,
    segundo_apellido,
	municipio,
    municipio_ocurrencia,
    fecha_nacimiento,
    fecha_ocurrencia
    FROM 
    defunciones
    INNER JOIN 
    municipio mn ON municipio = mn.id_municipio
    INNER JOIN 
    municipio mf ON municipio_ocurrencia = mf.id_municipio;")->fetchAll();
    }

    public function obtenerDepartamento()
    {
        return $this->_db->query("select * from departamento;")->fetchAll();
    }

    public function obtenerCausas()
    {
        return $this->_db->query("select * from causas;")->fetchAll();
    }


    public function obtenerMunicipio($idDepartamento)
    {
        return $this->_db->query("select * from municipio where departamento_id_departamento='$idDepartamento'")->fetchAll();
    }

    public function insertarDefuncion(
        $primerNombre,
        $segundoNombre,
        $primerApellido,
        $segundoApellido,
        $cedula,
        $etnia,
        $municipio,
        $fechaNacimiento,
        $edadCumplida,
        $sexo,
        $nacionalidad,
        $estadoCivil,
        $nombreConyugue,
        $ocupacion,
        $fechaOcurrencia,
        $municipioOcurrencia,
        $causaMuerte,
        $horaDefuncion,
        $nombreFamiliar,
        $sexoFamiliar,
        $correoFamiliar,
        $userFamiliar,
        $claveFamiliar

    ) {
        $sql = 'INSERT INTO defunciones (
                    primer_nombre, 
                    segundo_nombre, 
                    primer_apellido, 
                    segundo_apellido, 
                    cedula, 
                    etnia, 
                    municipio, 
                    fecha_nacimiento, 
                    edad_cumplida, 
                    sexo, 
                    nacionalidad, 
                    estado_civil, 
                    nombre_conyugue, 
                    ocupacion, 
                    fecha_ocurrencia, 
                    municipio_ocurrencia, 
                    hora_defuncion, 
                    causa_muerte
                ) VALUES (
                    :primerNombre, 
                    :segundoNombre, 
                    :primerApellido, 
                    :segundoApellido, 
                    :cedula, 
                    :etnia, 
                    :municipio, 
                    :fechaNacimiento, 
                    :edadCumplida, 
                    :sexo, 
                    :nacionalidad, 
                    :estadoCivil, 
                    :nombreConyugue, 
                    :ocupacion, 
                    :fechaOcurrencia, 
                    :municipioOcurrencia, 
                    :horaDefuncion, 
                    :causaMuerte
                )';

        $stmt = $this->_db->prepare($sql);
        $stmt->execute(array(
            'primerNombre' => $primerNombre,
            'segundoNombre' => $segundoNombre,
            'primerApellido' => $primerApellido,
            'segundoApellido' => $segundoApellido,
            'cedula' => $cedula,
            'etnia' => $etnia,
            'municipio' => $municipio,
            'fechaNacimiento' => $fechaNacimiento,
            'edadCumplida' => $edadCumplida,
            'sexo' => $sexo,
            'nacionalidad' => $nacionalidad,
            'estadoCivil' => $estadoCivil,
            'nombreConyugue' => $nombreConyugue,
            'ocupacion' => $ocupacion,
            'fechaOcurrencia' => $fechaOcurrencia,
            'municipioOcurrencia' => $municipioOcurrencia,
            'horaDefuncion' => $horaDefuncion,
            'causaMuerte' => $causaMuerte
        ));

         // Retornar el último ID insertado
        $idDefuncion=$this->_db->lastInsertId();

        /*Envio de datos a la tabla familiar */
        $privilegio="familiar";
        $hash=password_hash($claveFamiliar, PASSWORD_DEFAULT);
         $this->_db->prepare('insert into familiar(nombre_completo,sexo,correo,usuario,familiar_difunto)
         values(:nombre,:sexo,:correo,:usuario,:defuncion)')->execute(array('nombre'=>$nombreFamiliar, 'sexo'=>$sexoFamiliar, 'correo'=>$correoFamiliar,'usuario'=>$userFamiliar,'defuncion'=>$idDefuncion ));
        /*Envio de datos a la tabla Usuario para generar su usuario */

        $this->_db->prepare('insert into usuario(nombre_usuario,clave,rol)
         values(:nombre,:clave,:rol)')->execute(array('nombre'=>$userFamiliar, 'clave'=>$hash, 'rol'=>$privilegio ));




    }


    public function actualizarCementerio($nombreUp, $municipioUp, $latitudUp, $longitudUp, $capacidadUp, $tipoUp, $horaAperturaUp, $horaCierreUp, $idCementerioUp)
    {
        $sql = 'UPDATE cementerio 
        SET nombre = :nombre, 
            latitud = :latitud, 
            longitud = :longitud, 
            capacidad = :capacidad, 
            tipo = :tipo, 
            hora_apertura = :hora_apertura, 
            hora_cierre = :hora_cierre, 
            municipio_id_municipio = :municipio 
        WHERE id_cementerio = :idCementerioUp';

        $stmt = $this->_db->prepare($sql);

        $stmt->execute(array(
            'nombre' => $nombreUp,
            'latitud' => $latitudUp,
            'longitud' => $longitudUp,
            'capacidad' => $capacidadUp,
            'tipo' => $tipoUp,
            'hora_apertura' => $horaAperturaUp,
            'hora_cierre' => $horaCierreUp,
            'municipio' => $municipioUp,
            'idCementerioUp' => $idCementerioUp
        ));

    }

    public function borrarCementerio($idCementerio)
    {
        $this->_db->prepare('delete from cementerio where id_cementerio=:idCementerio')->execute(array('idCementerio' => $idCementerio));
    }




}
