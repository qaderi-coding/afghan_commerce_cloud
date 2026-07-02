# FM1: Frontend Foundation — Enterprise Template Setup

> Standalone milestone. Must complete before any feature development (FM2+). Focus: reusable framework, Microsoft-inspired design, RTL + i18n.

---

## Technology Stack & Rationale

| Concern | Choice | Rationale |
|---------|--------|-----------|
| Framework | React 18 + TypeScript + Vite | Fast HMR, TypeScript inference, enterprise standard |
| Component Library | MUI v6 + MUI X DataGrid Pro | Enterprise-grade grid; Microsoft theme compatibility |
| Forms | Formik + Zod | Mature ecosystem; predictable for AI codegen; controlled forms |
| Server State | TanStack Query v5 | Caching, background refetch, optimistic updates, devtools |
| Client State | Redux Toolkit | See §2 for rationale |
| Routing | React Router v7 | Data routers, type-safe params, nested routes |
| Validation | Zod (shared with Formik) | Schema-first validation; integrates with Formik |
| HTTP Client | Axios | Interceptors for auth, retry, structured logging |
| Theming | MUI emotion theme | Dynamics 365 / Azure Portal aesthetic |
| i18n | react-i18next | Lazy-loaded locales; RTL support |
| Testing | Vitest + React Testing Library + Playwright | Fast unit tests + E2E for critical flows |

---

## 2. Client State Management: Redux Toolkit (Recommended)

**Why Redux Toolkit for large ERP:**

| Factor | Redux Toolkit | Alternative |
|--------|---------------|-------------|
| Scalability | Normalized state, time-travel, single source of truth | Zustand: simpler but harder to debug complex state |
| Maintainability | `createSlice` patterns, immutability, middleware ecosystem | Zustand: less boilerplate but less structure |
| Performance | Memoized selectors prevent re-renders in dense grids | Zustand: comparable; RTK better for granular updates |
| AI-Assisted | Established conventions, abundant training data, predictable file structure | Zustand: less opinionated, inconsistent patterns |

**State split:**
- **TanStack Query:** Server-derived data (entities, lists, audit logs)
- **Redux Toolkit:** UI-only state (theme density, sidebar, undo/redo stacks, draft persistence, print preview)
- **Formik:** Form values + field-level validation (never lifted to Redux)

---

## 3. Microsoft-Inspired Enterprise Theme

| Property | Value |
|----------|-------|
| Density | Compact (`-2` in MUI) |
| Font | Segoe UI / system stack |
| Accent color | `#0078d4` (Dynamics 365 blue) |
| Borders | Flat, 1px divider; no shadows |
| Status indicators | Left border + bold text (no colored pills) |
| Forms | Top-aligned labels, inline validation below fields |

---

## 4. Reusable Forms Framework

### Core Components

| Component | Purpose |
|-----------|---------|
| `ErpForm` | Formik wrapper with `Zod` schema integration |
| `FormField` | Label + input + error + help text; variants for TextField, Select, DatePicker |
| `LookupSearch` | Async autocomplete; debounced; create-new flow; cached via TanStack Query |
| `CurrencyInput` | AFN/USD toggle; 4 decimal validation; base equivalent display |
| `DynamicTable` | Form-driven mini grid for line items; uses `useFieldArray` + DataGrid |

### Validation Strategy

- Zod schemas co-located in `shared/contracts`
- Server errors mapped to field-level via `FormField` error prop
- Cross-field validation via `Zod.refine`

---

## 5. Reusable Tables Framework

| Component | Purpose |
|-----------|---------|
| `ErpDataGrid` | Base grid: server-side pagination/sorting/filtering, loading, empty state, export, print |
| `EditableDataGrid` | Inline editing; optimistic save; rollback on error; dirty indicators |
| `MasterDetailDataGrid` | Expandable rows: master + child (e.g., Invoice → Lines) |
| `CurrencyColumn` | Right-aligned; 4 decimals; RTL-aware |
| `StatusColumn` | Left border + bold text; no pills |

### Enterprise Capabilities

- Server-side pagination via TanStack Query `keepPreviousData`
- Column management (pin, hide, resize, reorder) to `localStorage` per user
- Export: CSV via MUI X; XLSX via `xlsx` library
- Print: CSS media query + `@react-pdf/renderer` for reports
- Keyboard navigation: Excel-style (arrows, Enter, Tab, F2)
- Virtualization for 10k+ rows

---

## 6. i18n & RTL Support

**Languages:** English (LTR), Dari (RTL), Pashto (RTL)

| Setup | Details |
|-------|---------|
| i18n instance | `i18n.ts` with `initReactI18next` |
| Locales | `public/locales/{en,prs,ps}/translation.json` |
| RTL detection | `i18n.dir()` → set MUI `theme.direction` |
| Language toggle | In sidebar footer; persists to Redux `ui.slice` |
| Date formatting | `date-fns` with locale-aware formatters |
| Number formatting | `Intl.NumberFormat` with 4 decimals for currency |

---

## 7. Project Structure

```
src/
├── app/
│   ├── layout.tsx          # Providers: Redux, Router, Query, Theme, i18n
│   ├── router.tsx          # React Router v7 data routers
│   └── routes.tsx          # Route definitions + auth guards
├── features/               # Vertical slices; independently testable
│   ├── auth/
│   ├── sales/
│   ├── purchasing/
│   ├── inventory/
│   ├── accounting/
│   ├── cash/
│   └── payroll/
├── shared/
│   ├── components/         # ErpDataGrid, ErpForm, FormField, LookupSearch
│   ├── hooks/              # useDebounce, useMediaQuery, usePrint, useAuth
│   ├── stores/             # Redux slices (ui, notifications, wizard)
│   ├── lib/                # apiClient, auth, i18n initialization
│   ├── contracts/          # Zod schemas + TypeScript types shared with backend
│   ├── theme/              # MUI enterprise theme configuration
│   └── utils/              # formatMoney, dateHelpers, exportHelpers
├── assets/
├── main.tsx
└── vite-env.d.ts
```

---

## 8. FM1 Tasks — Implementation Order

| Task | Category | Acceptance Criteria | Dependencies |
|------|----------|---------------------|--------------|
| FM1.1: Vite bootstrap | Project | `npm run dev` works; TS strict; ESLint | — |
| FM1.2: Install packages | Project | All core packages resolve; no conflicts | FM1.1 |
| FM1.3: i18n setup | Shared | English + Dari + Pashto locales; RTL toggle | FM1.1 |
| FM1.4: Theme system | Shared | Compact density; Segoe font; `#0078d4` accent; RTL styles | FM1.2 |
| FM1.5: Redux store | Shared | `ui.slice` with density/sidebar/language; DevTools | FM1.1 |
| FM1.6: QueryClient | Shared | Stale 30s; retry 1; DevTools enabled | FM1.1 |
| FM1.7: apiClient.ts | Shared | Axios interceptors; typed; error handling | FM1.2 |
| FM1.8: AppShell layout | App | Sidebar + CommandBar + Breadcrumb + Print layout | FM1.4 |
| FM1.9: ErpForm wrapper | Shared | Formik + Zod schema integration; error display | FM1.2 |
| FM1.10: FormField component | Shared | TextField/Select/DatePicker variants; RTL-aware | FM1.9 |
| FM1.11: LookupSearch | Shared | Debounced search; create-new; cache via Query | FM1.2, FM1.10 |
| FM1.12: CurrencyInput | Shared | AFN/USD toggle; 4 decimals; RTL layout | FM1.10 |
| FM1.13: ErpDataGrid base | Shared | Server pagination/sorting/filter; export; print | FM1.4 |
| FM1.14: AuthProvider | Features/auth | `useAuth()` hook; token in memory; refresh cookie | FM1.2, FM1.7 |
| FM1.15: ProtectedRoute | Features/auth | `hasPermission(module, action)` check; redirect | FM1.14 |
| FM1.16: Router config | App | Nested routes; auth guards; type-safe params | FM1.15 |
| FM1.17: Loading states | Shared | Skeletons for grids; empty state illustrations | FM1.13 |
| FM1.18: Vitest setup | Testing | Tests run; coverage; basic RTL components | FM1.9, FM1.13 |
| FM1.19: Accessibility baseline | Shared | axe-core; skip links; keyboard indicators | FM1.13, FM1.10 |
| FM1.20: Build verification | Project | `npm run build` succeeds; Lighthouse > 90 perf | All above |

---

## 9. DoD — FM1 Complete

- [ ] `npm run dev` shows login screen in enterprise theme
- [ ] Sidebar navigation with placeholder links
- [ ] RTL toggle works (layout flips)
- [ ] Language switching loads translations
- [ ] Redux DevTools shows `ui.slice`
- [ ] TanStack Query DevTools shows cache
- [ ] ErpForm validates with Zod schema
- [ ] LookupSearch searches with debounce
- [ ] CurrencyInput validates 4 decimals
- [ ] ErpDataGrid shows server-paginated data
- [ ] ProtectedRoute blocks unauthorized
- [ ] Vitest runs with 80%+ coverage
- [ ] `npm run build` produces production bundle

---

## 10. AI-Agent Guardrails

- Never inline styles; use `sx` prop or `styled()`
- Never store JWT in localStorage; use memory + HttpOnly refresh
- Use Zod schemas from `shared/contracts` for Formik validation
- Grid columns: `GridColDef[]` with `type`, `width`, `editable`, `valueFormatter`
- Redux slices: `features/X/store/slice.ts` for feature UI state
- Component exports: `components/index.ts` barrel file per feature
- Tests: `*.test.tsx` co-located with components