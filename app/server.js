const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 3000;
const TICKETS_FILE = path.join(__dirname, '../itsm/ticket-database/tickets.json');

// Helper to read tickets
function getTickets() {
  try {
    const data = fs.readFileSync(TICKETS_FILE, 'utf8');
    return JSON.parse(data);
  } catch (err) {
    return [];
  }
}

// Helper to save tickets
function saveTickets(tickets) {
  fs.writeFileSync(TICKETS_FILE, JSON.stringify(tickets, null, 2), 'utf8');
}

const server = http.createServer((req, res) => {
  // Allow all preview hosts
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  if (req.method === 'OPTIONS') {
    res.writeHead(204);
    res.end();
    return;
  }

  const url = new URL(req.url, `http://${req.headers.host}`);

  // API Endpoints
  if (url.pathname === '/api/tickets' && req.method === 'GET') {
    const tickets = getTickets();
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify(tickets));
    return;
  }

  if (url.pathname === '/api/tickets' && req.method === 'POST') {
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const newTicket = JSON.parse(body);
        const tickets = getTickets();
        
        // Auto ID generation
        const count = tickets.length + 1;
        const prefix = newTicket.type === 'Requisição de Serviço' ? 'REQ' : 'INC';
        newTicket.id = `${prefix}-2026-${1040 + count}`;
        newTicket.created_at = new Date().toISOString().replace('T', ' ').substring(0, 16);
        newTicket.status = newTicket.status || 'Novo';
        newTicket.sla_met = true;
        newTicket.csat_rating = null;
        newTicket.csat_feedback = null;
        
        tickets.unshift(newTicket);
        saveTickets(tickets);

        res.writeHead(201, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(newTicket));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Payload inválido' }));
      }
    });
    return;
  }

  // Update Ticket (Resolve / Escalate)
  if (url.pathname.startsWith('/api/tickets/') && req.method === 'POST') {
    const ticketId = url.pathname.split('/')[3];
    let body = '';
    req.on('data', chunk => { body += chunk; });
    req.on('end', () => {
      try {
        const updateData = JSON.parse(body);
        const tickets = getTickets();
        const index = tickets.findIndex(t => t.id === ticketId);
        
        if (index === -1) {
          res.writeHead(404, { 'Content-Type': 'application/json' });
          res.end(JSON.stringify({ error: 'Ticket não encontrado' }));
          return;
        }

        tickets[index] = { ...tickets[index], ...updateData };
        if (updateData.status === 'Resolvido' && !tickets[index].resolved_at) {
          tickets[index].resolved_at = new Date().toISOString().replace('T', ' ').substring(0, 16);
        }
        saveTickets(tickets);

        res.writeHead(200, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify(tickets[index]));
      } catch (e) {
        res.writeHead(400, { 'Content-Type': 'application/json' });
        res.end(JSON.stringify({ error: 'Erro ao atualizar' }));
      }
    });
    return;
  }

  // Serve static UI
  const filePath = path.join(__dirname, 'public/index.html');
  fs.readFile(filePath, (err, content) => {
    if (err) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Erro ao carregar aplicação ITSM');
      return;
    }
    res.writeHead(200, { 'Content-Type': 'text/html; charset=utf-8' });
    res.end(content);
  });
});

server.listen(PORT, '0.0.0.0', () => {
  console.log(`[ITSM Lab] Servidor operacional N1 escutando na porta ${PORT} (0.0.0.0)`);
});
