---
title: Language Selection
layout: page
---

<div class="lang-selection-container">
  <h1 class="lang-selection-title">请选择语言 / Please Select Language</h1>
  <div class="lang-cards">
    <a href="/cn/" class="lang-card">
      <div class="lang-flag">🇨🇳</div>
      <div class="lang-name">中文</div>
      <div class="lang-desc">简体中文</div>
    </a>
    <a href="/en/" class="lang-card">
      <div class="lang-flag">🇬🇧</div>
      <div class="lang-name">English</div>
      <div class="lang-desc">English</div>
    </a>
  </div>
</div>

<style>
.lang-selection-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  min-height: 60vh;
  padding: 40px 20px;
}

.lang-selection-title {
  font-size: 2.5em;
  margin-bottom: 50px;
  color: #333;
  text-align: center;
}

.lang-cards {
  display: flex;
  gap: 40px;
  flex-wrap: wrap;
  justify-content: center;
}

.lang-card {
  width: 250px;
  padding: 40px 20px;
  border-radius: 12px;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  text-decoration: none;
  box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
  transition: transform 0.3s, box-shadow 0.3s;
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.lang-card:hover {
  transform: translateY(-10px);
  box-shadow: 0 15px 40px rgba(102, 126, 234, 0.4);
}

.lang-flag {
  font-size: 4em;
  margin-bottom: 20px;
}

.lang-name {
  font-size: 2em;
  font-weight: bold;
  margin-bottom: 10px;
}

.lang-desc {
  font-size: 1.1em;
  opacity: 0.9;
}
</style>
