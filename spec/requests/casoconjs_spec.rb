# encoding: UTF-8

require 'spec_helper'

describe "Llenar caso con javascript", :js => true do
  before { 
    usuario = Usuario.find_by(nusuario: 'sjrven')
    usuario.password = 'sjrven123'
    visit new_usuario_session_path 
    fill_in "Usuario", with: usuario.nusuario
    fill_in "Clave", with: usuario.password
    click_button "Iniciar Sesión"
    #print page.html
    #page.save_screenshot('s.png')
    #save_and_open_page
    expect(page).to have_content("Administrar")
  }

  describe "administrador llena" do
    it "puede crear caso con datos mínimos" do
      visit new_caso_path
      @numcaso=find_field('Código').value

      # Datos básicos
      fill_in "Fecha de Recepción", with: '2014-08-04'
      fill_in "Fecha del Hecho", with: '2014-08-03'
      fill_in "Descripción", with: 'datos mínimos'

      # Sol principal
      click_on "Solicitante Principal"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitanate'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      click_button "Guardar"
      page.save_screenshot('s-sol1.png')
      if (find_button('Guardar').visible?)
        click_on "Guardar"
      end
      page.save_screenshot('s-sol2.png')
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar" do
      visit new_caso_path
      # Datos básicos
      fill_in "Fecha de Recepción", with: '2014-08-04'
      fill_in "Fecha del Hecho", with: '2014-08-03'
      fill_in "Descripción", with: 'con familiar'

      # Sol principal
      click_on "Solicitante Principal"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitanate'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('s-sol1.png')
      click_on "Solicitante Principal"
      page.save_screenshot('s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
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
        select('De 0 a 15 Años', from: 'Rango de Edad')
        select('ROM', from: 'Etnia') 
        select('IGLESIA DE DIOS', from: 'Religión/Iglesia') 
        select('HETEROSEXUAL', from: 'Orientación Sexual') 
        select('CASADO/A', from: 'Estado Civil') 
        select('HIJO(A)', from: 'Rol en Familia') 
        select('GESTANTE', from: 'Maternidad') 
        select('SENSORIAL', from: 'Discapacidad') 
        fill_in "Enfermedad", with: 'Enfermedad'
        select('PESCADOR', from: 'Actividad/Oficio actual') 
        select('PRIMARIA', from: 'Nivel Escolar') 
      end
      page.save_screenshot('s-fam1.png')
      click_button "Guardar"
      page.save_screenshot('s-fam2.png')
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar mínimo y 1 ubicación" do
      visit new_caso_path
      # Datos básicos
      fill_in "Fecha de Recepción", with: '2014-08-04'
      fill_in "Fecha del Hecho", with: '2014-08-03'
      fill_in "Descripción", with: 'descripcion con javascript'

      # Sol principal
      click_on "Solicitante Principal"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitanate'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('s-sol1.png')
      click_on "Solicitante Principal"
      page.save_screenshot('s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
      within ("div#victima") do 
        fill_in "Nombres", with: 'Nombres Beneficiario'
        fill_in "Apellidos", with: 'Apellidos Beneficiario'
      end
      page.save_screenshot('s-fam1.png')
      click_on "Núcleo Familiar"
      page.save_screenshot('s-fam2.png')

      # Sitios Geográficos
      click_link "Sitios geográficos de refugios y desplazamientos"
      if (!find_link('Añadir Sitio Geográfico').visible?)
        click_link "Sitios geográficos de refugios y desplazamientos"
      end
      expect(page).to have_content "Añadir Sitio Geográfico"
      page.save_screenshot('s-geo0.png')
      click_on "Añadir Sitio Geográfico"
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
      page.save_screenshot('s-geo1.png')
      click_button "Guardar"
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con familiar mínimo, 2 ubicaciones, ref y desp" do
      visit new_caso_path
      # Datos básicos
      fill_in "Fecha de Recepción", with: '2014-08-04'
      fill_in "Fecha del Hecho", with: '2014-08-03'
      fill_in "Descripción", with: 'descripcion con javascript'

      # Sol principal
      click_on "Solicitante Principal"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitanate'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('s-sol1.png')
      click_on "Solicitante Principal"
      page.save_screenshot('s-sol2.png')

      # Núcleo familiar
      click_on "Núcleo Familiar"
      click_on "Añadir Víctima"
      within ("div#victima") do 
        fill_in "Nombres", with: 'Nombres Beneficiario'
        fill_in "Apellidos", with: 'Apellidos Beneficiario'
      end
      page.save_screenshot('s-fam1.png')
      click_on "Núcleo Familiar"
      page.save_screenshot('s-fam2.png')

      # Sitios Geográficos
      click_link "Sitios geográficos de refugios y desplazamientos"
      if (!find_link('Añadir Sitio Geográfico').visible?)
        click_link "Sitios geográficos de refugios y desplazamientos"
      end
      expect(page).to have_content "Añadir Sitio Geográfico"
      page.save_screenshot('s-geo0.png')
      click_on "Añadir Sitio Geográfico"
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
      page.save_screenshot('s-geo1.png')
      expect(find_link('Añadir Sitio Geográfico').visible?).to be true
      click_on "Añadir Sitio Geográfico"
      page.save_screenshot('s-geo2.png')
      su = "//div[@id='ubicacion']/div/div[2]"
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
      page.save_screenshot('s-geo3.png')
      click_on "Sitios geográficos de refugios y desplazamientos"

      # Refugio
      click_on "Refugio"
      if (!find(:css, '#caso_casosjr_attributes_id_salida').visible?)
        click_on "Refugio"
      end
      expect(page).to have_field('Fecha de Salida', with: '2014-08-03')
      within ("div#refugio") do 
        find('#caso_casosjr_attributes_id_salida').click
        select('VENEZUELA / ARAGUA', from: 'Sitio de Salida') 
        fill_in "Fecha de Llegada", with: '2014-08-04'
        find('#caso_casosjr_attributes_id_llegada').click
        select('COLOMBIA / BOYACÁ', from: 'Sitio de Llegada') 
        select('R2000 RAZA', from: 'Causa del Refugio') 
        fill_in "Observaciones", with: 'Observaciones refugio'
      end
      page.save_screenshot('s-ref1.png')
      click_on "Refugio"
      page.save_screenshot('s-ref2.png')

      #Desplazamiento
      click_on "Desplazamientos"
      if (!find_link('Añadir Desplazamiento').visible?)
        click_on "Desplazamientos"
      end
      click_on "Añadir Desplazamiento"
      page.save_screenshot('s-desp1.png')
      if (!find_field('Fecha de Expulsión').visible?)
        click_on "Añadir Desplazamiento"
      end
      page.save_screenshot('s-desp1-5.png')
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
      page.save_screenshot('s-desp2.png')
      click_on "Desplazamientos"
      page.save_screenshot('s-desp3.png')
      click_button "Guardar"
      expect(page).to have_content("2014-08-03")
    end

    it "puede crear caso con solicitante, p. resp y acto" do
      visit new_caso_path
      # Datos básicos
      fill_in "Fecha de Recepción", with: '2014-08-04'
      fill_in "Fecha del Hecho", with: '2014-08-03'
      fill_in "Descripción", with: 'descripcion con javascript'

      # Sol principal
      click_on "Solicitante Principal"
      #if (!find_link('Añadir Sitio Geográfico').visible?)
      #  click_link "Sitios geográficos de refugios y desplazamientos"
      #end
      expect(page).to have_content "Nombres"
      within ("div#contacto") do 
        fill_in "Nombres", with: 'Nombres Solicitanate'
        fill_in "Apellidos", with: 'Apellidos Solicitante'
      end
      page.save_screenshot('s-sol1.png')
      click_on "Solicitante Principal"
      page.save_screenshot('s-sol2.png')

      #Desplazamiento
      click_on "Agente de Persecución"
      if (!find_link('Añadir Agente de Persecución').visible?)
        click_on "Agente de Persecución"
      end
      click_on "Añadir Agente de Persecución"
      page.save_screenshot('s-pr1.png')
      if (!find_field('Presunto Responsable').visible?)
        click_on "Añadir Desplazamiento"
      end
      expect(find('#presponsable')).to have_field( 'Presunto Responsable')
      within ("#presponsable") do 
        select('AUC', from: 'Presunto Responsable') 
        fill_in "Bloque", with: 'b1'
        fill_in "Frente", with: 'f1'
        fill_in "Brigada", with: 'b1'
        fill_in "Otro", with: 'o1'
      end
      page.save_screenshot('s-pr2.png')
      click_on "Agente de Persecución"
      page.save_screenshot('s-pr3.png')

      #Acto
      click_on "Causas/Antecedentes"
      if (!find_link('Añadir Causa/Antecedente').visible?)
        click_on "Causas/Antecedentes"
      end
      click_on "Añadir Causa/Antecedente"
      page.save_screenshot('s-a1.png')
      if (!find_field('Categoria').visible?)
        click_on "Añadir Causa/Antecedente"
      end
      page.save_screenshot('s-a2.png')
      expect(find('#antecedentes')).to have_field( 'Categoria')
      within ("#antecedentes") do 
        find_field('Presunto Responsable').click
        select('AUC', from: 'Presunto Responsable') 
        select('A23 HERIDO', from: 'Categoria') 
        find_field('Víctima').click
        select('Nombres Solicitanate Apellidos Solicitante', from: 'Víctima') 
      end
      page.save_screenshot('s-a3.png')
      click_on "Causas/Antecedentes"
      page.save_screenshot('s-a4.png')
 
      click_button "Guardar"
      page.save_screenshot('s-g.png')
      expect(page).to have_content("2014-08-03")
    end

  end

end
