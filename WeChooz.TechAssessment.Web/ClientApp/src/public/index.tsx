import ReactDOM, { Container } from "react-dom/client";
import { SessionsTable } from "./sessions";
import "./index.css";

const root = ReactDOM.createRoot(document.getElementById("react-app") as Container);
root.render(
    <div className="min-h-screen flex flex-col bg-slate-950 text-slate-100">
        <header className="bg-slate-900 border-b border-slate-700 px-8 py-5 shadow-lg">
            <h1 className="text-3xl font-bold tracking-tight">Formations</h1>
        </header>
        <main className="flex-1 flex justify-center px-4 py-10">
            <SessionsTable />
        </main>
        <footer className="bg-slate-900 border-t border-slate-700 px-8 py-4 text-center text-slate-400 text-sm">
            <p>© 2026 Afahd Ali — WeChooz Tech Assessment</p>
        </footer>
    </div>
);
