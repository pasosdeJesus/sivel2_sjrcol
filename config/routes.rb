Rails.application.routes.draw do

  devise_scope :usuario do
    get 'sign_out' => 'devise/sessions#destroy'
    # El siguiente para superar mala generación del action en el formulario
    # cuando se autentica mal y esta montado no en / (genera 
    # /puntomontaje/puntomontaje/usuarios/sign_in )
    if (Rails.configuration.relative_url_root != '/') 
      ruta = File.join(Rails.configuration.relative_url_root, 
                       'usuarios/sign_in')
      post ruta, to: 'devise/sessions#create'
      get  ruta, to: 'devise/sessions#new'
    end
  end
  devise_for :usuarios, :skip => [:registrations], module: :devise
    as :usuario do
          get 'usuarios/edit' => 'devise/registrations#edit', 
            :as => 'editar_registro_usuario'    
          put 'usuarios/:id' => 'devise/registrations#update', 
            :as => 'registro_usuario'            
  end
  resources :usuarios, path_names: { new: 'nuevo', edit: 'edita' } 


  patch "/actos/agregar" => 'sivel2_sjr/actos#agregar',
    as: :actos_agregar
  get "/actos/eliminar" => 'sivel2_sjr/actos#eliminar',
    as: :actos_eliminar
 
  get "/conteos/accionesjuridicas" => 'sivel2_sjr/conteos#accionesjuridicas', 
    as: :conteos_accionesjuridicas
  get "/conteos/desplazamientos" => 'sivel2_sjr/conteos#desplazamientos', 
    as: :conteos_desplazamientos
  get "/conteos/municipios" => 'sivel2_sjr/conteos#municipios', 
    as: :conteos_municipios
  get "/conteos/rutas" => 'sivel2_sjr/conteos#rutas', 
    as: :contes_rutas
  get "/conteos/vacios" => 'sivel2_sjr/conteos#vacios',
    as: :conteos_vacios

 get '/migraciones/nuevo' => 'sivel2_sjr/migraciones#nuevo'  
 
  #get "/personas" => 'sip/personas#index'
  #get "/personas/remplazar" => 'sip/personas#remplazar'
    get "/casos/:id/fichaimp" => "sivel2_sjr/casos#fichaimp", 
         as: :caso_fichaimp
     
     get "/casos/:id/fichapdf" => "sivel2_sjr/casos#fichapdf", 
          as: :caso_fichapdf 
  root "sip/hogar#index"

  mount Sivel2Sjr::Engine, at: "/", as: 'sivel2_sjr'
  mount Sivel2Gen::Engine, at: "/", as: 'sivel2_gen'
  mount Cor1440Gen::Engine, at: "/", as: 'cor1440_gen'
  mount Sal7711Gen::Engine, at: "/", as: 'sal7711_gen'
  mount Mr519Gen::Engine, at: "/", as: 'mr519_gen'
  mount Heb412Gen::Engine, at: "/", as: 'heb412_gen'
  mount Sip::Engine, at: "/", as: 'sip'

  namespace :admin do
    ab = ::Ability.new
    ab.tablasbasicas.each do |t|
      if (t[0] == "") 
        c = t[1].pluralize
        resources c.to_sym, 
          path_names: { new: 'nueva', edit: 'edita' }
      end
    end
  end
end
