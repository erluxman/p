import CssBaseline from "@mui/material/CssBaseline";
import { ThemeProvider, createTheme } from "@mui/material/styles";
import { Provider } from "react-redux";
import "./App.css";
import { TodoListScreen } from "./presentation/screens/todo_list_screen";
import { store } from "./presentation/state/store";

const theme = createTheme({
  palette: {
    mode: "light",
  },
});

function App() {
  return (
    <Provider store={store}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <TodoListScreen />
      </ThemeProvider>
    </Provider>
  );
}

export default App;
