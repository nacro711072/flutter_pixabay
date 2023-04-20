[2023-04-20]
- Refactor home page
  - [Router] Refactor router
  - [DI] home page dependency refactor
  - [UI] 拆分元件
  
[2023-04-19]
- Add loading indicator
  - [Home UI] Change `opacity` when loading progressing.
  - [Home UI] Ignore pointer when loading progressing.
  
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