#!/usr/bin/env python3
"""Tier-0 sticker drafts on SPARK flux-schnell (gen-queue). Starts no earlier
than START, concurrency 2, saves PNGs + index next to this script.
Usage: python3 run_batch.py [--now]"""
import json, sys, time, datetime, urllib.request, urllib.error, concurrent.futures, os, random
BASE = 'http://192.168.88.66:8091'
INFER = f'{BASE}/nim/flux-schnell/v1/infer'
START = datetime.datetime.now().replace(hour=19, minute=15, second=0, microsecond=0)
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'out')
os.makedirs(OUT, exist_ok=True)
prompts = json.load(open(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'prompts.json')))

def req(url, data=None, raw=False):
    r = urllib.request.Request(url, data=json.dumps(data).encode() if data is not None else None,
                               headers={'Content-Type': 'application/json'} if data is not None else {})
    with urllib.request.urlopen(r, timeout=120) as resp:
        return resp.read() if raw else json.loads(resp.read() or b'{}')

def one(item):
    path = os.path.join(OUT, item['id'] + '.png')
    if os.path.exists(path): return item['id'], 'exists'
    seed = random.randint(1, 2**31 - 1)
    try:
        job = req(INFER, {'prompt': item['prompt'], 'width': 1024, 'height': 1024, 'seed': seed, 'steps': 4})
        jid = job['id']
        for _ in range(240):
            st = req(f'{BASE}/nim/flux-schnell/jobs/{jid}')
            s = str(st.get('status', st.get('state', ''))).lower()
            if s in ('done', 'completed', 'succeeded', 'finished', 'ok'): break
            if s in ('failed', 'error', 'cancelled'): return item['id'], f'failed: {st}'
            time.sleep(2)
        png = req(f'{BASE}/nim/flux-schnell/jobs/{jid}/result', raw=True)
        open(path, 'wb').write(png)
        json.dump({'id': item['id'], 'seed': seed, 'prompt': item['prompt']},
                  open(os.path.join(OUT, item['id'] + '.json'), 'w'), ensure_ascii=False, indent=1)
        return item['id'], 'ok'
    except Exception as e:
        return item['id'], f'error: {e}'

if __name__ == '__main__':
    if '--now' not in sys.argv:
        while datetime.datetime.now() < START:
            time.sleep(30)
    done = 0; log = open(os.path.join(OUT, 'log.txt'), 'a')
    with concurrent.futures.ThreadPoolExecutor(max_workers=2) as ex:
        for id_, status in ex.map(one, prompts):
            log.write(f'{datetime.datetime.now().isoformat()} {id_} {status}\n'); log.flush()
            if status in ('ok', 'exists'): done += 1
    print(f'{done}/{len(prompts)} images in {OUT}')
