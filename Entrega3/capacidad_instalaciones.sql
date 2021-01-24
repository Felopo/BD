CREATE OR REPLACE FUNCTION
capacidad_instalaciones(fecha_inicio date, fecha_salida date, puerto varchar)
RETURNS TABLE (id_inst int, fechas varchar(255), promedio real) AS $$
DECLARE
    t_instalacion RECORD;
    id_actual int;
    fecha_actual date;
    cant_permisos int;
    capacidad_actual int;
    promedio_temp real;

    t_instalacion2 RECORD;
    t_temporal RECORD;
    suma_promedios real;
    contador int;
BEGIN
    CREATE TABLE inst_temporal (id_insta int, fecha date, promedio_dia real);

    FOR t_instalacion IN SELECT id_instalacion, capacidad FROM Instalacion WHERE nombre_puerto = puerto LOOP
        id_actual := t_instalacion.id_instalacion;
        capacidad_actual := t_instalacion.capacidad;
        fecha_actual := fecha_inicio;
        WHILE fecha_actual <= fecha_salida LOOP
            SELECT INTO cant_permisos COUNT(fecha_atraque) FROM permiso WHERE DATE(fecha_atraque) = fecha_actual AND id_instalacion_permiso = id_actual; 
            promedio_temp := cant_permisos/capacidad_actual::float*100;
            INSERT INTO inst_temporal VALUES(id_actual, fecha_actual, promedio_temp);
            fecha_actual := fecha_actual + 1;
        END LOOP;
    END LOOP;

    FOR t_instalacion2 IN SELECT id_instalacion FROM Instalacion WHERE nombre_puerto = puerto LOOP
        id_inst := t_instalacion2.id_instalacion;
        fechas := '';
        contador := 0;
        suma_promedios := 0;
        FOR t_temporal IN SELECT * FROM inst_temporal WHERE inst_temporal.id_insta = id_inst LOOP
            suma_promedios := suma_promedios + t_temporal.promedio_dia;
            IF t_temporal.promedio_dia != 100 THEN
                fechas := fechas || '/' || to_char(t_temporal.fecha, 'YYYY-MM-DD');
            END IF;
            contador := contador + 1;
        END LOOP;
        promedio := suma_promedios/contador;
        RETURN NEXT;
    END LOOP;

    DROP TABLE inst_temporal;
    RETURN;
END
$$ language plpgsql