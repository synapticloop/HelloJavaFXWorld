module synapticloop.javafx.hellojavafxworld {
	requires javafx.controls;
	requires javafx.fxml;
	requires java.desktop;


	opens synapticloop.javafx.hellojavafxworld to javafx.fxml;
	exports synapticloop.javafx.hellojavafxworld;
}