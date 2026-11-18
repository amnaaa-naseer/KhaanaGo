export const apiBase = 'http://127.0.0.1:8787'

let authToken: string | null = null

export function setToken(token: string | null) {
  authToken = token
}

export async function api(path: string, options: { method?: string; role?: string; body?: unknown } = {}) {
  const response = await fetch(`${apiBase}${path}`, {
    method: options.method ?? 'GET',
    headers: {
      'content-type': 'application/json',
      'x-role': options.role ?? 'vendor_owner',
      ...(authToken ? { authorization: `Bearer ${authToken}` } : {}),
    },
    body: options.body ? JSON.stringify(options.body) : undefined,
  })
  const data = await response.json()
  if (!response.ok) throw new Error(data.error || 'Something went wrong.')
  return data
}
