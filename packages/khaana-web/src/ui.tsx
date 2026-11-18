import type { ButtonHTMLAttributes, ReactNode } from 'react'

type Variant = 'primary' | 'secondary' | 'ghost'

type ButtonProps = ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: Variant
  loading?: boolean
}

export function Button({ variant = 'primary', loading = false, disabled, children, className = '', ...props }: ButtonProps) {
  return (
    <button className={`btn ${variant} ${loading ? 'loading' : ''} ${className}`.trim()} disabled={disabled || loading} {...props}>
      {loading ? 'Loading' : children}
    </button>
  )
}

export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
  return <article className={`card ${className}`.trim()}>{children}</article>
}

export function Chip({ selected, children, ...props }: ButtonHTMLAttributes<HTMLButtonElement> & { selected?: boolean }) {
  return (
    <button className="chip" aria-pressed={selected} {...props}>{children}</button>
  )
}

export function StatusBadge({ tone = 'available', children }: { tone?: string; children: ReactNode }) {
  return <span className={`badge ${tone}`}>{children}</span>
}

export function EmptyState({ children }: { children: ReactNode }) {
  return <p className="empty">{children}</p>
}

export function ErrorState({ message, action, onRetry }: { message: string; action: string; onRetry: () => void }) {
  return (
    <div className="error">
      <p>{message}</p>
      <Button onClick={onRetry}>{action}</Button>
    </div>
  )
}

export function Skeleton({ lines = 3 }: { lines?: number }) {
  return (
    <div className="skeleton" aria-hidden="true">
      {Array.from({ length: lines }, (_, index) => <i key={index} />)}
    </div>
  )
}

export function Stepper({ steps, current }: { steps: string[]; current: number }) {
  return (
    <ol className="stepper">
      {steps.map((label, index) => (
        <li key={label} className={index === current ? 'current' : index < current ? 'done' : undefined}>
          <span className="mark" />
          <strong>{label}</strong>
        </li>
      ))}
    </ol>
  )
}
