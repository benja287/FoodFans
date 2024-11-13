// Importa Turbo para manejar los métodos DELETE y otros métodos HTTP
import { Turbo } from "@hotwired/turbo-rails";
Turbo.start();

// Importa Stimulus
import { Application } from "@hotwired/stimulus";

const application = Application.start();
application.debug = false;
window.Stimulus = application;

export { application };
