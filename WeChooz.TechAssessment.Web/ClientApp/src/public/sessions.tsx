import { useEffect, useState } from "react";

interface Session {
    courseTitle: string;
    shortDescription: string;
    startDate: string;
    durationInDays: number;
    instructor: string;
    longDescription: string;
}

export function SessionsTable() {
    const [sessions, setSessions] = useState<Session[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

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

    if (loading) return <p>Loading sessions...</p>;
    if (error) return <p>Error: {error}</p>;
    if (sessions.length === 0) return <p>No sessions available.</p>;

    return (
        <table>
            <thead>
                <tr>
                    <th>Course title</th>
                    <th>Short description</th>
                    <th>Start date</th>
                    <th>Duration (days)</th>
                    <th>Instructor</th>
                </tr>
            </thead>
            <tbody>
                {sessions.map((s, i) => (
                    <tr key={i}>
                        <td>{s.courseTitle}</td>
                        <td>{s.shortDescription}</td>
                        <td>{s.startDate}</td>
                        <td>{s.durationInDays}</td>
                        <td>{s.instructor}</td>
                    </tr>
                ))}
            </tbody>
        </table>
    );
}