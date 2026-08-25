(() => {
  const buttons = document.querySelectorAll('[data-language]');
  const contents = document.querySelectorAll('[data-lang-content]');
  const savedLanguage = localStorage.getItem('flutterunit-language');
  const preferredLanguage = navigator.language.toLowerCase().startsWith('zh') ? 'zh' : 'en';

  function setLanguage(language) {
    contents.forEach((content) => {
      content.hidden = content.dataset.langContent !== language;
    });
    buttons.forEach((button) => {
      button.setAttribute('aria-pressed', String(button.dataset.language === language));
    });
    document.documentElement.lang = language === 'zh' ? 'zh-CN' : 'en';
    localStorage.setItem('flutterunit-language', language);
  }

  buttons.forEach((button) => {
    button.addEventListener('click', () => setLanguage(button.dataset.language));
  });

  setLanguage(savedLanguage || preferredLanguage);
})();
