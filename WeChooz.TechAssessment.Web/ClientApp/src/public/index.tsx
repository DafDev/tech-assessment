import ReactDOM, { Container } from "react-dom/client";
import { SessionsTable } from "./sessions";

const root = ReactDOM.createRoot(document.getElementById("react-app") as Container);
root.render(<SessionsTable />);
