# encoding: UTF-8

require 'spec_helper'

describe "Llenar caso con javascript", :js => true, type: :feature do
  before { 
    usuario = Usuario.find_by(nusuario: 'sjrven')
    usuario.password = 'sjrven123'
    visit new_usuario_session_path 
    page.save_screenshot('tmp/aut1.png')
    fill_in "Usuario", with: usuario.nusuario
    fill_in "Clave", with: usuario.password
    click_button "Iniciar Sesión"
    #print page.html
    #page.save_screenshot('tmp/s.png')
    #save_and_open_page
    expect(page).to have_content("Administrar")
  }

  describe "administrador llena" do
    it "puede crear caso con datos mínimos" do
      visit '/casos/nuevo'
      @numcaso=find_field('Código').value

      # Datos básicos
      fill_in "Fecha Primera Recepción", with: '2014-08-04'
      fill_in "F. Desplazamiento Emblemático", with: '2014-08-03'
      #fill_in "Memo", with: 'datos mínimos'

      # Sol principal
      click_on "Contacto"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitante'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      click_on "Validar y Guardar"
      page.save_screenshot('tmp/s-sol1.png')
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar", type: :feature do
      visit '/casos/nuevo'
      # Datos básicos
      fill_in "Fecha Primera Recepción", with: '2014-08-04'
      fill_in "F. Desplazamiento Emblemático", with: '2014-08-03'
      #fill_in "Memo", with: 'con familiar'

      # Sol principal
      click_on "Contacto"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitante'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('tmp/s-sol1.png')
      click_on "Contacto"
      page.save_screenshot('tmp/s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
      wait_for_ajax
      page.save_screenshot('tmp/s-sol3.png')
      within ("div#victima") do 
        fill_in "Nombres", with: 'Nombres Beneficiario'
        fill_in "Apellidos", with: 'Apellidos Beneficiario'
        fill_in "Año Nacimiento", with: '1999'
        fill_in "Mes Nacimiento", with: '1'
        fill_in "Día Nacimiento", with: '1'
        select("MASCULINO", from: 'Sexo')
        select("CÉDULA DE CIUDADANÍA", from: 'Tipo de Documento')
        fill_in "Número Documento", with: '19222'
        select('ALBANIA', from: 'País de Nacionalidad')
        select('RUSIA', from: 'País de Nacimiento')
        select('OTRO', from: 'Profesión')
        #select('DE 0 A 5 AÑOS', from: 'Rango de Edad')
        select('ROM', from: 'Etnia') 
        select('HETEROSEXUAL', from: 'Orientación Sexual') 
        select('CASADO/A', from: 'Estado Civil') 
        select('HIJO(A)', from: 'Rol en Familia') 
        select('GESTANTE', from: 'Maternidad') 
        select('PESCADOR', from: 'Actividad/Oficio actual') 
        select('PRIMARIA', from: 'Nivel Escolar') 
      end
      page.save_screenshot('tmp/s-fam1.png')
      click_on "Validar y Guardar"
      page.save_screenshot('tmp/s-fam2.png')
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar mínimo y 1 ubicación" do
      visit '/casos/nuevo'
      # Datos básicos
      page.save_screenshot('tmp/s-sol0.png')
      fill_in "Fecha Primera Recepción", with: '2014-08-04'
      fill_in "F. Desplazamiento Emblemático", with: '2014-08-03'
      #fill_in "Memo", with: 'descripcion con javascript'

      # Sol principal
      click_on "Contacto"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitante'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('tmp/s-sol1.png')
      click_on "Contacto"
      page.save_screenshot('tmp/s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
      within ("div#victima") do 
        fill_in "Nombres", with: 'Nombres Beneficiario'
        fill_in "Apellidos", with: 'Apellidos Beneficiario'
      end
      page.save_screenshot('tmp/s-fam1.png')
      click_on "Núcleo Familiar"
      page.save_screenshot('tmp/s-fam2.png')

      # Sitios Geográficos
      click_link "Ubicación"
      if (!find_link('Añadir Ubicación').visible?)
        click_link "Ubicación"
      end
      expect(page).to have_content "Añadir Ubicación"
      page.save_screenshot('tmp/s-geo0.png')
      click_on "Añadir Ubicación"
      within ("div#ubicacion") do 
        select('VENEZUELA', from: 'País') 
        select('ARAGUA', from: 'Estado/Departamento') 
        select('CAMATAGUA', from: 'Municipio') 
        select('CARMEN DE CURA', from: 'Centro Poblado') 
        fill_in "Lugar", with: 'Lugar'
        fill_in "Sitio", with: 'Sitio'
        fill_in "Latitud", with: '4.1'
        fill_in "Longitud", with: '-74.3'
        select('URBANO', from: 'Tipo de Sitio') 
      end
      page.save_screenshot('tmp/s-geo1.png')
      click_on "Validar y Guardar"
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar mínimo, 2 ubicaciones, ref y desp", type: :feature do
      visit '/casos/nuevo'
      # Datos básicos
      fill_in "Fecha Primera Recepción", with: '2014-08-04'
      fill_in "F. Desplazamiento Emblemático", with: '2014-08-03'
      #fill_in "Memo", with: 'descripcion con javascript'

      # Sol principal
      click_on "Contacto"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitante'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('tmp/s-sol1.png')
      click_on "Contacto"
      page.save_screenshot('tmp/s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
      within ("div#victima") do 
        fill_in "Nombres", with: 'Nombres Beneficiario'
        fill_in "Apellidos", with: 'Apellidos Beneficiario'
      end
      page.save_screenshot('tmp/s-fam1.png')
      click_on "Núcleo Familiar"
      page.save_screenshot('tmp/s-fam2.png')

      # Sitios Geográficos
      click_link "Ubicación"
      if (!find_link('Añadir Ubicación').visible?)
        click_link "Ubicación"
      end
      expect(page).to have_content "Añadir Ubicación"
      page.save_screenshot('tmp/s-geo0.png')
      click_on "Añadir Ubicación"
      within ("div#ubicacion") do 
        select('VENEZUELA', from: 'País') 
        select('ARAGUA', from: 'Estado/Departamento') 
        select('CAMATAGUA', from: 'Municipio') 
        select('CARMEN DE CURA', from: 'Centro Poblado') 
        fill_in "Lugar", with: 'Lugar'
        fill_in "Sitio", with: 'Sitio'
        fill_in "Latitud", with: '4.1'
        fill_in "Longitud", with: '-74.3'
        select('URBANO', from: 'Tipo de Sitio') 
      end
      page.save_screenshot('tmp/s-geo1.png')
      expect(find_link('Añadir Ubicación').visible?).to be true
      click_on "Añadir Ubicación"
      wait_for_ajax
      page.save_screenshot('tmp/s-geo2.png')
      # Si es acordeon su = "//div[@id='ubicacion']/div/div[2]"
      su = "//div[@id='ubicacion']/div[2]"
      within(:xpath, su) do 
        select('COLOMBIA', from: 'País') 
        select('BOYACÁ', from: 'Estado/Departamento') 
        select('CHISCAS', from: 'Municipio') 
        select('CHISCAS', from: 'Centro Poblado') 
        fill_in "Lugar", with: 'Lugar2'
        fill_in "Sitio", with: 'Sitio2'
        fill_in "Latitud", with: '4.2'
        fill_in "Longitud", with: '-74.32'
        select('RURAL', from: 'Tipo de Sitio') 
      end
      page.save_screenshot('tmp/s-geo3.png')
      click_on "Ubicación"

      # Refugio
      click_on "Refugio"
      if (!find(:css, '#caso_casosjr_attributes_id_salida').visible?)
        click_on "Refugio"
      end
      expect(page).to have_field('Fecha de Salida', with: '2014-08-03')
      within ("div#refugio") do 
        find('#caso_casosjr_attributes_id_salida').click
        page.save_screenshot('tmp/s-ref0.png')
        select('VENEZUELA / ARAGUA', from: 'Sitio de Salida') 
        fill_in "Fecha de Llegada", with: '2014-08-04'
        find('#caso_casosjr_attributes_id_llegada').click
        select('COLOMBIA / BOYACÁ', from: 'Sitio de Llegada') 
        select('R2000 RAZA', from: 'Causa del Refugio') 
        fill_in "Observaciones", with: 'Observaciones refugio'
      end
      page.save_screenshot('tmp/s-ref1.png')
      click_on "Refugio"
      page.save_screenshot('tmp/s-ref2.png')

      #Desplazamiento
      click_on "Desplazamientos"
      if (!find_link('Añadir Desplazamiento').visible?)
        click_on "Desplazamientos"
      end
      click_on "Añadir Desplazamiento"
      page.save_screenshot('tmp/s-desp1.png')
      if (!find_field('Fecha de Expulsión').visible?)
        click_on "Añadir Desplazamiento"
      end
      page.save_screenshot('tmp/s-desp1-5.png')
      expect(find('#desplazamiento')).to have_field( 'Fecha de Expulsión')
      within ("#desplazamiento") do 
        fill_in "Fecha de Expulsión", with: '2014-08-03'
        find_field('Sitio de Expulsión').click
        select('VENEZUELA / ARAGUA', from: 'Sitio de Expulsión') 
        fill_in "Fecha de Llegada", with: '2014-08-04'
        find_field('Sitio de Llegada').click
        select('COLOMBIA / BOYACÁ', from: 'Sitio de Llegada') 
        fill_in "Descripción", with: 'Descripción desplazamiento'
      end
      page.save_screenshot('tmp/s-desp2.png')
      click_on "Desplazamientos"
      page.save_screenshot('tmp/s-desp3.png')
      click_on "Validar y Guardar"
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con solicitante, p. resp y acto" do
      skip # Por arreglar acto
      visit '/casos/nuevo'
      # Datos básicos
      fill_in "Fecha Primera Recepción", with: '2014-08-04'
      fill_in "F. Desplazamiento Emblemático", with: '2014-08-03'
      #fill_in "Memo", with: 'descripcion con javascript'

      # Sol principal
      click_on "Contacto"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitante'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('tmp/s-sol1.png')
      click_on "Contacto"
      page.save_screenshot('tmp/s-sol2.png')

      #Desplazamiento
      click_on "Presuntos Responsables"
      if (!find_link('Añadir Presunto Responsable').visible?)
        click_on "Presuntos Responsables"
      end
      click_on "Añadir Presunto Responsable"
      page.save_screenshot('tmp/s-pr1.png')
      if (!find_field('Presunto Responsable').visible?)
        click_on "Añadir Presunto Responsable"
      end
      expect(find('#presponsable')).to have_field( 'Presunto Responsable')
      within ("#presponsable") do 
        select('AUC', from: 'Presunto Responsable') 
        fill_in "Bloque", with: 'b1'
        fill_in "Frente", with: 'f1'
        fill_in "Brigada", with: 'b1'
        fill_in "Otro", with: 'o1'
      end
      page.save_screenshot('tmp/s-pr2.png')
      click_on "Presuntos Responsables"
      page.save_screenshot('tmp/s-pr3.png')

      #Acto
      sleep 1
      click_on "Causas/Antecedentes"
      sleep 1
      page.save_screenshot('tmp/s-a0.png')
      if (!find_link('Añadir Causa/Antecedente').visible?)
        click_on "Causas/Antecedentes"
      end
      page.save_screenshot('tmp/s-a2.png')
      expect(find('#antecedentes')).to have_field( 'Categoria')
      within ("#antecedentes") do 
        find_field('caso_acto_id_presponsable').click
        select('AUC', from: 'caso_acto_id_presponsable') 
        select('A23 HERIDO', from: 'Categoria') 
        find_field('Víctima').click
        select('Nombres Solicitante Apellidos Solicitante', from: 'Víctima') 
      end
      page.save_screenshot('tmp/s-a3.png')
      click_on "Añadir Causa/Antecedente"
      page.save_screenshot('tmp/s-a4.png')
      click_on "Causas/Antecedentes"
      page.save_screenshot('tmp/s-a5.png')
 
      click_on "Validar y Guardar"
      page.save_screenshot('tmp/s-g.png')
      # no se entiende porque no funciona:
      # expect(page).to have_content("2014-08-03")
    end

  end

end
