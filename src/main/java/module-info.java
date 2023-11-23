module synapticloop.javafx.hellojavafxworld {
	requires javafx.controls;
	requires javafx.fxml;


	opens synapticloop.javafx.hellojavafxworld to javafx.fxml;
	exports synapticloop.javafx.hellojavafxworld;
}