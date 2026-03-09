export class Sessions {
    public static getSession(): string | null {
        return sessionStorage.getItem('session');
    }
}