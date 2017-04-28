import static javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.FileChooser;


protected File selectFilteredInput(String title, File start, ExtensionFilter... filters) {

  FileChooser fileChooser = new FileChooser();
  fileChooser.setTitle(title);
  fileChooser.setInitialDirectory(start);
  fileChooser.getExtensionFilters().addAll(filters);
  File selectedFile = fileChooser.showOpenDialog(null);
  return selectedFile;
}