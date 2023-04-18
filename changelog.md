[2023-04-18]
- Update search bar UI
  - [IconButton] Adjust ripple effect size (too large).
  - [IconButton] Centered icon position.
  - [Search bar] Centered input text.
  - [Search bar] Use OutlineBoarder.
- Implement SharedPreferences to load/save query history.
  - [Di] Inject `SharedPreference` / `QueryHistoryRepository`
  - [UI] Show suggestion(history) list.
  - [UI] Do keyword searching when suggestion item clicked.