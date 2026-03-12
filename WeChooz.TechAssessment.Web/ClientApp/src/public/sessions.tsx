import { useEffect, useState } from "react";
import Markdown from "react-markdown";

interface Session {
    courseTitle: string;
    shortDescription: string;
    longDescription: string;
    startDate: string;
    durationInDays: number;
    instructor: string;
    availableSeats: number;
}

type FilterMode = "all" | "after" | "before" | "between";

export function SessionsTable() {
    const [sessions, setSessions] = useState<Session[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);
    const [filterMode, setFilterMode] = useState<FilterMode>("all");
    const [filterFrom, setFilterFrom] = useState("");
    const [filterTo, setFilterTo] = useState("");
    const [selected, setSelected] = useState<Session | null>(null);

    useEffect(() => {
        fetch("/api/sessions")
            .then((res) => {
                if (!res.ok) throw new Error(`Failed to load sessions (${res.status})`);
                return res.json() as Promise<Session[]>;
            })
            .then((data) => setSessions(data))
            .catch((err: Error) => setError(err.message))
            .finally(() => setLoading(false));
    }, []);

    const filtered = sessions.filter((s) => {
        const d = new Date(s.startDate);
        if (filterMode === "after" && filterFrom) return d >= new Date(filterFrom);
        if (filterMode === "before" && filterFrom) return d <= new Date(filterFrom);
        if (filterMode === "between") {
            const from = filterFrom ? new Date(filterFrom) : null;
            const to = filterTo ? new Date(filterTo) : null;
            if (from && d < from) return false;
            if (to && d > to) return false;
        }
        return true;
    });

    if (loading) return <p className="text-slate-400 text-center py-16">Loading sessions...</p>;
    if (error) return <p className="text-red-400 text-center py-16">Error: {error}</p>;

    return (
        <div className="w-full max-w-6xl">
            {/* Date filter bar */}
            <div className="flex flex-wrap items-end gap-4 mb-6 bg-slate-800/60 rounded-xl p-4 border border-slate-700">
                <div>
                    <label className="block text-xs text-slate-400 mb-1 uppercase tracking-wide">Filter by date</label>
                    <select
                        value={filterMode}
                        onChange={(e) => { setFilterMode(e.target.value as FilterMode); setFilterFrom(""); setFilterTo(""); }}
                        className="bg-slate-700 border border-slate-600 text-slate-100 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                    >
                        <option value="all">All dates</option>
                        <option value="after">After</option>
                        <option value="before">Before</option>
                        <option value="between">Between</option>
                    </select>
                </div>
                {(filterMode === "after" || filterMode === "before" || filterMode === "between") && (
                    <div>
                        <label className="block text-xs text-slate-400 mb-1 uppercase tracking-wide">
                            {filterMode === "between" ? "From" : "Date"}
                        </label>
                        <input
                            type="date"
                            value={filterFrom}
                            onChange={(e) => setFilterFrom(e.target.value)}
                            className="bg-slate-700 border border-slate-600 text-slate-100 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                        />
                    </div>
                )}
                {filterMode === "between" && (
                    <div>
                        <label className="block text-xs text-slate-400 mb-1 uppercase tracking-wide">To</label>
                        <input
                            type="date"
                            value={filterTo}
                            onChange={(e) => setFilterTo(e.target.value)}
                            className="bg-slate-700 border border-slate-600 text-slate-100 rounded-lg px-3 py-2 text-sm focus:outline-none focus:ring-2 focus:ring-indigo-500"
                        />
                    </div>
                )}
                <span className="text-slate-500 text-sm ml-auto">
                    {filtered.length} of {sessions.length} session{sessions.length !== 1 ? "s" : ""}
                </span>
            </div>

            {/* Sessions table */}
            {filtered.length === 0 ? (
                <p className="text-slate-400 text-center py-16">No sessions match your filter.</p>
            ) : (
                <div className="overflow-x-auto rounded-xl border border-slate-700 shadow-xl">
                    <table className="w-full text-sm text-left">
                        <thead className="bg-slate-800 text-slate-300 uppercase text-xs tracking-wider">
                            <tr>
                                <th className="px-5 py-4">Course</th>
                                <th className="px-5 py-4">Short description</th>
                                <th className="px-5 py-4">Start date</th>
                                <th className="px-5 py-4">Duration</th>
                                <th className="px-5 py-4">Instructor</th>
                                <th className="px-5 py-4 text-center">Available seats</th>
                            </tr>
                        </thead>
                        <tbody className="divide-y divide-slate-700/60">
                            {filtered.map((s, i) => (
                                <tr key={i} className="bg-slate-900 hover:bg-slate-800/70 transition-colors">
                                    <td className="px-5 py-4">
                                        <button
                                            onClick={() => setSelected(s)}
                                            className="font-medium text-indigo-400 hover:text-indigo-300 hover:underline text-left"
                                        >
                                            {s.courseTitle}
                                        </button>
                                    </td>
                                    <td className="px-5 py-4 text-slate-300 max-w-xs">{s.shortDescription}</td>
                                    <td className="px-5 py-4 text-slate-300 whitespace-nowrap">{s.startDate}</td>
                                    <td className="px-5 py-4 text-slate-300">{s.durationInDays}d</td>
                                    <td className="px-5 py-4 text-slate-300">{s.instructor}</td>
                                    <td className="px-5 py-4 text-center">
                                        <span className={`inline-flex items-center justify-center rounded-full px-2.5 py-0.5 text-xs font-semibold ${
                                            s.availableSeats > 0
                                                ? "bg-emerald-900/60 text-emerald-300"
                                                : "bg-red-900/60 text-red-300"
                                        }`}>
                                            {s.availableSeats > 0 ? s.availableSeats : "Full"}
                                        </span>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
            )}

            {/* Long-description modal */}
            {selected && (
                <div
                    className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/70"
                    onClick={() => setSelected(null)}
                >
                    <div
                        className="relative bg-slate-900 rounded-2xl border border-slate-700 shadow-2xl w-full max-w-2xl max-h-[85vh] flex flex-col"
                        onClick={(e: React.MouseEvent) => e.stopPropagation()}
                    >
                        <div className="flex items-start justify-between px-6 pt-6 pb-4 border-b border-slate-700">
                            <h2 className="text-xl font-bold text-white pr-8">{selected.courseTitle}</h2>
                            <button
                                onClick={() => setSelected(null)}
                                className="text-slate-400 hover:text-white text-2xl leading-none shrink-0 mt-0.5"
                                aria-label="Close"
                            >
                                ×
                            </button>
                        </div>
                        <div className="overflow-y-auto px-6 py-5 markdown">
                            <Markdown>{selected.longDescription}</Markdown>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}